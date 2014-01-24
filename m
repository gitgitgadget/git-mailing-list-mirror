From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] repack.c: chmod +w before rename()
Date: Fri, 24 Jan 2014 22:05:14 +0100
Message-ID: <201401242205.16313.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: tboegi@web.de,
 zwanzig12@googlemail.com,
 stefanbeller@googlemail.com,
 kusmabite@gmail.com,
 Johannes.Schindelin@gmx.de,
 msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBCUZ3EUT2ADRBGFLROLQKGQEMP5Y7WI@googlegroups.com Fri Jan 24 22:05:33 2014
Return-path: <msysgit+bncBCUZ3EUT2ADRBGFLROLQKGQEMP5Y7WI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f61.google.com ([209.85.215.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBGFLROLQKGQEMP5Y7WI@googlegroups.com>)
	id 1W6nwO-0006Ik-RE
	for gcvm-msysgit@m.gmane.org; Fri, 24 Jan 2014 22:05:28 +0100
Received: by mail-la0-f61.google.com with SMTP id c6sf510502lan.6
        for <gcvm-msysgit@m.gmane.org>; Fri, 24 Jan 2014 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=subject:to:cc:from:date:mime-version:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=nnGiVVucb023zUpmNW7Qqt2YnTFfCBRH6PqIuQ2bNeA=;
        b=nZBINU6PV8nA+tOoIWsUayv0nuA7ALA+fP7xShcO3DYgoyv5WYR0V4jZSzjL71ZA2B
         eLA1oRRAYnDPdOpfhn8O2UFCZD6Rn8LVlodA08zvpIxIgJxdLFWH8pmn4e70+HhshxzY
         1NEUYhpNp63uATLQiiGiLv1wcNGFudiUx8y231l125KJDuKYd/gWaaIH8e17i4VWycft
         boL2hL1zDvv6v4GZ5T7kQr+11xEMkkgmDCzWxw3+p8w4fxjTtwGrk1O07N0tr8ZfK54x
         GQ5FaIKnnPDcXYlaVaSCB7C5cgX9us48KDGA1Not1rzFxX9ucng2XIF2KQA9mOuVifX3
         o3mg==
X-Received: by 10.152.1.102 with SMTP id 6mr10201lal.30.1390597528550;
        Fri, 24 Jan 2014 13:05:28 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.3 with SMTP id p3ls283549lag.0.gmail; Fri, 24 Jan 2014
 13:05:27 -0800 (PST)
X-Received: by 10.112.62.138 with SMTP id y10mr214383lbr.18.1390597527562;
        Fri, 24 Jan 2014 13:05:27 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.15.4])
        by gmr-mx.google.com with ESMTPS id f47si749360eem.0.2014.01.24.13.05.27
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2014 13:05:27 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of tboegi@web.de designates 212.227.15.4 as permitted sender) client-ip=212.227.15.4;
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Lr2Zb-1VbZqu0VwB-00ed7g for <msysgit@googlegroups.com>;
 Fri, 24 Jan 2014 22:05:27 +0100
X-Provags-ID: V03:K0:0aj7nk5W8v9+45oZl2lO0MWJI7tyaf4sNh+ERJmSgXIXstSdq8L
 bL8SzyBds54tVa34sYiegT3WFKEpsEqfFr9HKpj8/588C7qn3OUHPFaQnAb8tnk5W3C8PJa
 FBceZXfJcnkNyqBnRfTSgK7v4L+ALK1Wu7KC9NPWD+FEhGl7uAUNgnP9f6NRJ8p4dHOJQKE
 uJB3GCmjRS78x8+G0UoWA==
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of tboegi@web.de designates
 212.227.15.4 as permitted sender) smtp.mail=tboegi@web.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241040>

commit a1bbc6c0 "repack: rewrite the shell script in C" introduced
a possible regression, when a Git repo is located on a Windows network shar=
e.

When git gc is called on an already packed repository, it could fail like t=
his:
"fatal: renaming '.git/objects/pack/.tmp-xyz.pack' failed: Permission denie=
d"

Temporary *.pack and *.idx files remain in .git/objects/pack/

In a1bbc6c0 the rename() function replaced the "mv -f" shell command.

Obviously the -f option can also override a read-only file but
rename() can not on a network share.

Make the C-code to work similar to the shell script, by making the
files writable before calling rename().

Another solution could be to do the "chmod +x" in mingw_rename().
This may be done in another commit, because
a) It improves git gc only when Git for Windows is used
   on the client machine
b) Windows refuses to delete a file when the file is read-only.
   So setting a file to read-only under Windows is a way for a user
   to protect it from being deleted.
   Changing the behaviour of rename() globally may not be what we want.

Reported-by: Jochen Haag <zwanzig12@googlemail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 builtin/repack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index ba66c6e..033b4c2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -324,6 +324,10 @@ int cmd_repack(int argc, const char **argv, const char=
 *prefix)
 				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
 				chmod(fname_old, statbuffer.st_mode);
 			}
+			if (!stat(fname, &statbuffer)) {
+				statbuffer.st_mode |=3D (S_IWUSR | S_IWGRP | S_IWOTH);
+				chmod(fname, statbuffer.st_mode);
+			}
 			if (rename(fname_old, fname))
 				die_errno(_("renaming '%s' failed"), fname_old);
 			free(fname);
--=20
1.9.rc0.143.g6fd479e

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
