From: Ole Tange <ole@tange.dk>
Subject: git diff HEAD^(255) fails
Date: Sat, 6 Feb 2016 22:56:46 +0100
Message-ID: <CA+4vN7w2=JWusWDhhGNzAkJbE-s44G4WoXdvf26yzvtYfpktfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 22:57:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSAqu-0003TY-Ke
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 22:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbcBFV5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 16:57:08 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36500 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbcBFV5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2016 16:57:06 -0500
Received: by mail-ig0-f182.google.com with SMTP id xg9so35102659igb.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 13:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=5/7urkFs38L98WV2yT35SQPHGN7FHxVPoWRr28UyJuc=;
        b=LJK2kfxM2VNamec/qfLeZL9ELzKgH5gOectfrg96HxTui5yCWTwtFFSIwsUw1TQxxd
         Lf65jWMZ0v2m6J3oAWei/mkXsANDkyJkd/FCwvVckaiHqGaVVYQEdm5emPJ1HNedPoDo
         OjkG5bxSNLkRYj2Q2BlX5WY3yGF9HWV02Bkta+OquDbXJOZj4hH2wUXiC+HgJP/RdE99
         8p1pd8UEYZNPQ0tGDnXe6vqvFWm7HoyjlwEinZ0/RO+vy7TfCS7up2xNCoTLu6EXI6dO
         ZekJDqpoU/UBg1d8GFgTktx6CdhMWT0KHoYy84tGCt/87r4swEdFK4G1+/8pjm9eyJF7
         JDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-type:content-transfer-encoding;
        bh=5/7urkFs38L98WV2yT35SQPHGN7FHxVPoWRr28UyJuc=;
        b=ESRPPcFDQ0aNsNQFx6tQ+j5nFGztb/YjDb9Znx3NC2SMhS/Ujd70L55yPZmUmraPIB
         T6w+H8mYc2EeDpN2iwlNxc7KWsEOhCSE7VojzBeNFWAbCZCkh/BVCHD/bB/GO3ijap58
         pJn1Lw3EmCqM46HsP6LjgaaeO5LHIXG042St17W0FUftgC+Vkz14hh8uzaDvzXLxfWXo
         MytSlVvh1jpEkHc7pTWIyHBi85mA7ormDUUi7tkhPPGaB0fglFW4LRqotTrDHMkjDJ+5
         luZJH61nMySFCc14GlCgJp7I3xrO767D8K15g/PLnZxTDNz2KlmthwsyT5ZQ8hcgc5Pq
         bXOg==
X-Gm-Message-State: AG10YORp8+TQNEWfmUN7pJ1KNSTENzn3kxDny+zyNU6thoOg9SFBwvkq68ujMj7grmAb8DxCn5IZxeWpP8FGeQ==
X-Received: by 10.50.73.102 with SMTP id k6mr164411igv.97.1454795825656; Sat,
 06 Feb 2016 13:57:05 -0800 (PST)
Received: by 10.107.20.135 with HTTP; Sat, 6 Feb 2016 13:56:46 -0800 (PST)
X-Google-Sender-Auth: uOyLqAfwSt5A-BGHuzPgOUV2qds
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285704>

git diff first looks for a file, then looks if it is a reference to a
revision. If the file fails due to being too long, the diff fails:

$ git init
$ git diff 'HEAD^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
HEAD
fatal: failed to stat
'HEAD^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^':
File name too long

If file name too long it should just try to see if it is a reference
to a revision.


/Ole
