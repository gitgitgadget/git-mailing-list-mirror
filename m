From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Clone to an SSH destination
Date: Mon, 3 Sep 2012 13:26:42 +0200
Message-ID: <CACBZZX7Pe5gsfpFTihE33a1Exia_4dbMQ9p_Xc_z4Ry=Et9KLA@mail.gmail.com>
References: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mark Hills <Mark.Hills@framestore.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8UoZ-00054q-Fc
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 13:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298Ab2ICL1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 07:27:04 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37688 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab2ICL1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 07:27:03 -0400
Received: by obbuo13 with SMTP id uo13so8959415obb.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EkfLxP8XtpnltSvd18DS3SfdLpYfnD6ctYeqwsM3Ip8=;
        b=kLFVPrBaL2R6X16NGQ/V6eN3yuJmkVMyJAF3+RBvcFWrvfdkAKHaOtYsHFP6mJ6BPZ
         ACZMpgoVQB0RPNhcC8t5mwPZnyUDjcCU+N3UzXeWDKFIFrqKAwR+Lj4GlGrxkqaZmGm5
         e8HOSgXCBD6K0WyqGBXcHJYg4nd8T7zbdCciv9edfT7h+NAwD8icg8MHJQW498slL28F
         wQhpjBGlFn9FSOwwwZUIrVkzcmiRoNXFRrGC6mLdxWpS0KUssZ0bn516LNfNOJ5n76SS
         Hjdn3l0DbpkNS1oCEwMeMVTEtTaS/WKYfCmFxritxsS5jdiKXJv1XI8WTFWRwcjGcmFo
         sxiA==
Received: by 10.60.29.228 with SMTP id n4mr14095777oeh.27.1346671622515; Mon,
 03 Sep 2012 04:27:02 -0700 (PDT)
Received: by 10.182.48.34 with HTTP; Mon, 3 Sep 2012 04:26:42 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204687>

On Mon, Sep 3, 2012 at 12:21 PM, Mark Hills <Mark.Hills@framestore.com> wrote:
> How do I clone a repo _to_ a new repo over SSH? I tried:
>
>   cd xx
>   git clone --bare . gitserver:/scm/xx.git
>   git clone --bare . ssh://gitserver/scm/xx.git
>
> This does not have the expected result, and instead a local path of the
> given name is created (eg. a 'gitserver:' directory)
>
> This seems to be a FAQ, but the only answer I can find (Google) is to
> login to the server and create the repo, setup a remote and push to it.

Basically Git doesn't support this yet, mainly because it could only
be supported with the ssh or local transports.

With anything else it would break, so push can only assume that
something on the other end can receive data, can update branch
pointers etc. Not create a brand new repository.

You could of course supply your devs with an alias that ssh's to that
server, does an init if needed, and then does a push.

> This is quite cumbersome; we have a large team of devs who use a simple
> 'git clone' to an NFS directory, but we wish to retire NFS access.
>
> Is there a technical limiation preventing clone-to-ssh, or just something
> waiting to be implemented?

But I'm actually more curious about why you need this in the first
place, there's a bunch of devs where I work as well, but they never
have the need to create new repos on some NFS drive in this manner.

What are your devs doing when they do clone their current working
directory to some NFS location, maybe there's a better way to do it.
