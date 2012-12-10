From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] mingw_rmdir: do not prompt for retry when non-empty
Date: Mon, 10 Dec 2012 09:26:26 -0800
Message-ID: <7vehixbyyl.fsf@alter.siamese.dyndns.org>
References: <1355150547-8212-1-git-send-email-kusmabite@gmail.com>
 <7vr4mxc1rd.fsf@alter.siamese.dyndns.org>
 <CABPQNSZL-edn4izfMuss1-3KbLBSrGm8J08wn0TbETtsn2nn+A@mail.gmail.com>
 <alpine.DEB.1.00.1212101804290.32206@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,  git@vger.kernel.org, 
 msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBRFWTCDAKGQE6ENW3BA@googlegroups.com Mon Dec 10 18:26:45 2012
Return-path: <msysgit+bncBCG77UMM3EJRBRFWTCDAKGQE6ENW3BA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBRFWTCDAKGQE6ENW3BA@googlegroups.com>)
	id 1Ti77r-0005zX-AX
	for gcvm-msysgit@m.gmane.org; Mon, 10 Dec 2012 18:26:43 +0100
Received: by mail-vc0-f186.google.com with SMTP id fl17sf2321910vcb.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 10 Dec 2012 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=IpXvEk+nwkdWBoSOWC2DZwOdp7oOm5niDxaQ7s9dtOI=;
        b=F1iaD/YLeooObgbFCqTQRIJGvj7SIL/UXB6lOlWalU6+vVaz9xRVVM5698dE8K2ACO
         NO8DjcD01hOKTn1VS0dzLeCt4xCHGFrJaMX2METQZU+adsd/BPCbrz9SqbUextexSYDB
         A98zrxkhfk4JtvXOvVpsNMQgq/1V6z92k6SZlzhmSWXiPtRcgCkgca8L+RsfIEuypbRm
         IOUvF60YAPyze8mE3krCDuo4hfEYOdqa/WwL8NZbf9dIia4nZ/ZYylJYJrx5Xc/L2mTy
         M1w7nDcXBVXj3y1iU+QIOrAtEeh+03kheYbFdKwzQ7vkYTaWHp4XdFhnUmVlwBvBwpS 
Received: by 10.49.87.1 with SMTP id t1mr3278053qez.41.1355160390234;
        Mon, 10 Dec 2012 09:26:30 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.35.74 with SMTP id f10ls3890705qej.48.gmail; Mon, 10 Dec
 2012 09:26:28 -0800 (PST)
Received: by 10.224.105.205 with SMTP id u13mr12281749qao.6.1355160388822;
        Mon, 10 Dec 2012 09:26:28 -0800 (PST)
Received: by 10.224.105.205 with SMTP id u13mr12281747qao.6.1355160388813;
        Mon, 10 Dec 2012 09:26:28 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id eb7si5492346qcb.3.2012.12.10.09.26.28;
        Mon, 10 Dec 2012 09:26:28 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DDEC86B3;
	Mon, 10 Dec 2012 12:26:28 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BC3D86B2;
	Mon, 10 Dec 2012 12:26:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3A8086B1; Mon, 10 Dec 2012
 12:26:27 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1212101804290.32206@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Mon, 10 Dec 2012 18:05:30 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAB7BA9A-42EE-11E2-8BF1-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211263>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My preference would be to fix it in both branches. I will fix the merge
> conflicts when rebasing onto Junio's master branch next time.

OK, then I'll queue the following to my tree.

Thanks for a quick turnaround.

-- >8 --
From: Erik Faye-Lund <kusmabite@gmail.com>
Date: Mon, 10 Dec 2012 15:42:27 +0100
Subject: [PATCH] mingw_rmdir: do not prompt for retry when non-empty

in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"),
a check was added to prevent us from retrying to delete a directory
that is both in use and non-empty.

However, this logic was slightly flawed; since we didn't return
immediately, we end up falling out of the retry-loop, but right into
the prompting-loop.

Fix this by setting errno, and guarding the prompting-loop with an
errno-check.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/mingw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 4e63838..28527ab 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -256,6 +256,8 @@ int mingw_rmdir(const char *pathname)
 
 	while ((ret = rmdir(pathname)) == -1 && tries < ARRAY_SIZE(delay)) {
 		if (!is_file_in_use_error(GetLastError()))
+			errno = err_win_to_posix(GetLastError());
+		if (errno != EACCES)
 			break;
 		if (!is_dir_empty(pathname)) {
 			errno = ENOTEMPTY;
@@ -271,7 +273,7 @@ int mingw_rmdir(const char *pathname)
 		Sleep(delay[tries]);
 		tries++;
 	}
-	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
+	while (ret == -1 && errno == EACCES && is_file_in_use_error(GetLastError()) &&
 	       ask_yes_no_if_possible("Deletion of directory '%s' failed. "
 			"Should I try again?", pathname))
 	       ret = rmdir(pathname);
-- 
1.8.1.rc1.123.gf61cb86

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
