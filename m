From: Zubin Mithra <zubin.mithra@gmail.com>
Subject: Certificate validation vulnerability in Git
Date: Sun, 24 Feb 2013 23:01:50 +0530
Message-ID: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Dhanesh K." <dhanesh1428@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 18:32:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9fQw-0008EX-06
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 18:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759013Ab3BXRbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 12:31:51 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32945 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758352Ab3BXRbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 12:31:50 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so1337559pad.28
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 09:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=NjcYTwCkQSYpodeVZ9cnnlDkYK+qfprpkTSm1YJCZVg=;
        b=z5MEjf1VxBqmRzyneCftxvN80mpX1i0CrmRGROWuhHyUCVsfJiH/K91UtEWKG7qv//
         D9Qch1161GEzgi2bo6IJDZJ+1TGQ7r7wH9nmX/xtBJwWSSouIUXihTu8BmuU8b/dcbyq
         EfhLvQIEwkwG4ufcUOZmjFFRhKdnRuaFyR2TkMmEKcJ7XCd23ew4R21XPhP/VYy5JbrS
         LOAvm5SoZIiZK4g7gSvwsaKI/dacFP9KPjdAE4hGRVCidDqeQntxx+cc1fE5ZtWq+ear
         fQwLfm6GFX8Yo28TFck3HHaxutw1xvYTdDFuQOZWuzVvU7FGJuhki85DV/nprftxvF/2
         z89A==
X-Received: by 10.66.184.208 with SMTP id ew16mr15092510pac.19.1361727110192;
 Sun, 24 Feb 2013 09:31:50 -0800 (PST)
Received: by 10.68.42.36 with HTTP; Sun, 24 Feb 2013 09:31:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216995>

Hello,

There seems to be a security issue in the way git uses openssl for
certificate validation. Similar occurrences have been found and
documented in other open source projects, the research can be found at
[1].

-=========]
- imap-send.c

Line 307

 307   ret = SSL_connect(sock->ssl);
 308   if (ret <= 0) {
 309     socket_perror("SSL_connect", sock, ret);
 310     return -1;
 311   }
 312

Certificate validation errors are signaled either through return
values of SSL_connect or by setting internal flags. The internal flags
need to be checked using the SSL_get_verify_result function. This is
not performed.

Kindly fix these issues, file a CVE and credit it to Dhanesh K. and
Zubin Mithra. Thanks.

We are not subscribed to this list, so we'd appreciate it if you could
CC us in the replies.

Hope this helps.

Thanks!
Zubin

[1] http://www.cs.utexas.edu/~shmat/shmat_ccs12.pdf
