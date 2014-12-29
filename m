From: Jiri Sevcik <jsevcik14@gmail.com>
Subject: Fwd: git-remote-fd problem
Date: Mon, 29 Dec 2014 10:47:58 +0100
Message-ID: <CAOP4-933YWoJ8QO0ZY2KG1cgtZ6jAR8oL4L9hw_0CcicDnepnQ@mail.gmail.com>
References: <CAOP4-939uAP2Tgofz01F40_Eb0F8GxBsU49HxNvAiyBCW6H08w@mail.gmail.com>
	<20140910144756.GA4267@LK-Perkele-VII>
	<CAOP4-92U+oFJJw38LWNmTqPtKMT=MDq0Ay9FiaGV5je77aUNpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113a73740549b4050b57c53a
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Dec 29 10:48:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5Wvm-0003WV-Hq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 10:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaL2JsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 04:48:00 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:55796 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbaL2Jr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 04:47:59 -0500
Received: by mail-qg0-f47.google.com with SMTP id q108so8956935qgd.20
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 01:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tz/tEU8UdMVnmP6r+XmpK+EiajV7p2j6y8mQFXkiT9E=;
        b=Ma4rPdSioivgdXJjxYlmxev2MFfeCkQ+5Sf9d8bwLJnSrW/pHLxRpy2oSJB/JuJfS9
         Ettxkm03miKqvkF3UDweg3TVrH5BcTOUiliNQhNd/Nhm7MBvKifOamv9RVjEonR9hs6B
         7+ChVSYLL26hdP3INI9SR0ZxBcmHkY5VGcGe4sixSm+nbGyD6VfFq6QpJdUWR3+BEPYt
         uJ38arLVGugOzftI616Mm63aLJ/G9cmq1m+bycypvsB5Uy/pwz9IXPCveseo+a1BRNvm
         llfgHS+fvpYFgLnXv250fkzC0GjbRWhPHCk9IyBRXGoQQxJH6V2bn2Y6475zlkTee3oe
         uyzg==
X-Received: by 10.140.94.117 with SMTP id f108mr73346540qge.50.1419846479064;
 Mon, 29 Dec 2014 01:47:59 -0800 (PST)
Received: by 10.96.16.7 with HTTP; Mon, 29 Dec 2014 01:47:58 -0800 (PST)
In-Reply-To: <CAOP4-92U+oFJJw38LWNmTqPtKMT=MDq0Ay9FiaGV5je77aUNpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261859>

--001a113a73740549b4050b57c53a
Content-Type: text/plain; charset=UTF-8

> The remote-fd expects the transport to pass half-closes. So you can't
> close all at once.
>
> Let there be pipes W and R and transport connection C.
>
> - W-read should be closed after being passed to remote-fd.
> - R-write should be closed after being passed to remote-fd.
> - Upon receiving "no more data" from C, close W-write.
> - Upon receiving EOF from R-read, close it and signal "no more data"
>   to C.

Hi, I followed your advices, correctly close pipes but git clone still
doesnt finish and hanging on.
Code is in an attachement (its part of big system).

--001a113a73740549b4050b57c53a
Content-Type: text/x-python; charset=US-ASCII; name="git_test_improved.py"
Content-Disposition: attachment; filename="git_test_improved.py"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i2rdm51q0

CiAgICAjY3JlYXRlIHBpcGVzCiAgICB3X3BpcGUgPSBvcy5waXBlKCkKICAgIHJfcGlwZSA9IG9z
LnBpcGUoKQoKICAgIGNsaWVudF9wcm9jZXNzID0gc3VicHJvY2Vzcy5Qb3BlbigiL3Vzci9iaW4v
Z2l0IGNsb25lIGZkOjp7MH0sezF9IC90bXAvZ2l0dGVzdCIuZm9ybWF0KHJfcGlwZVswXSwgd19w
aXBlWzFdKSwgc2hlbGw9VHJ1ZSkKICAgICNjbG9zaW5nIHBpcGVzCiAgICBvcy5jbG9zZShyX3Bp
cGVbMF0pIAogICAgb3MuY2xvc2Uod19waXBlWzFdKQoKICAgIGVwb2xsID0gc2VsZWN0LmVwb2xs
KCkKICAgIGVwb2xsLnJlZ2lzdGVyKHdfcGlwZVswXSwgc2VsZWN0LkVQT0xMSU4pCiAgICBlcG9s
bC5yZWdpc3Rlcihwcm9jLmZkLCBzZWxlY3QuRVBPTExJTikKCiAgICByZW1vdGVHaXQgPSBwcm9j
LnJ1bkRhZW1vbigiZ2l0LXVwbG9hZC1wYWNrIC90bXAvdGVzdGdpdCIpCiAgICAKICAgIHdoaWxl
IFRydWU6CiAgICAgICAgZXZlbnRzID0gZXBvbGwucG9sbCgxKQoKICAgICAgICBmb3IgZmQsIGV2
ZW50IGluIGV2ZW50czoKICAgICAgICAgICAgaWYgZmQgPT0gd19waXBlWzBdOgogICAgICAgICAg
ICAgICAgaWYgZXZlbnQgJiBzZWxlY3QuRVBPTExJTjoKICAgICAgICAgICAgICAgICAgICByZCA9
IG9zLnJlYWQod19waXBlWzBdLCAxMDAwMCkKICAgICAgICAgICAgICAgICAgICBpZiByZDoKICAg
ICAgICAgICAgICAgICAgICAgICAgI3dyaXRlIGRhdGEgdG8gcmVtb3ZlIGdpdCBzZXJ2ZXIKICAg
ICAgICAgICAgICAgICAgICAgICAgcmVtb3RlR2l0LndyaXRlVG9DaGFubmVsKHJkKQogICAgICAg
ICAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICAgICAgICAgIHByb2Mud3JpdGVFcnJv
cigiTG9jYWwgc29ja2V0IHdyaXRlIGVycm9yIikKICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIDEKICAgICAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICAgICAgcHJvYy53cml0
ZUVycm9yKCJMb2NhbCBzb2NrZXQgZXJyb3IiKQogICAgICAgICAgICAgICAgICAgIHJldHVybiAx
CgogICAgICAgICAgICBlbGlmIGZkID09IHByb2MuZmQ6CiAgICAgICAgICAgICAgICBpZiBldmVu
dCAmIHNlbGVjdC5FUE9MTElOOgogICAgICAgICAgICAgICAgICAgICNyZWFkIGRhdGEgZnJvbSBy
ZW1vdGUgZ2l0IHNlcnZlcgogICAgICAgICAgICAgICAgICAgIGRhdGEgPSByZW1vdGVHaXQuZ2V0
QWxsKCkKICAgICAgICAgICAgICAgICAgICByZW1vdGVHaXQuc3RkZXJyV3JpdGUoKQoKICAgICAg
ICAgICAgICAgICAgICBpZiBub3QgZGF0YToKICAgICAgICAgICAgICAgICAgICAgICAgI3JlbW90
ZSBzZXJ2ZXIgc2VuZCBFT0YsIGNsb3NlIGxvY2FsIHBpcGUKICAgICAgICAgICAgICAgICAgICAg
ICAgI2J1dCBnaXQgY2xvbmUgaXMgc3RpbGwgcnVubmluZwogICAgICAgICAgICAgICAgICAgICAg
ICBvcy5jbG9zZShyX3BpcGVbMV0pCiAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwCiAg
ICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgd2FudCA9IGxlbihkYXRhKQoK
ICAgICAgICAgICAgICAgICAgICB3cml0ZWQgPSAwCiAgICAgICAgICAgICAgICAgICAgb2Zmc2V0
ID0gMAogICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgIHdoaWxlKHdyaXRl
ZCAhPSB3YW50KToKICAgICAgICAgICAgICAgICAgICAgICAgI3dyaXRlIGRhdGEgZnJvbSByZW1v
dGUgZ2l0IHNlcnZlciB0byBsb2NhbCBwaXBlCiAgICAgICAgICAgICAgICAgICAgICAgIHdyID0g
b3Mud3JpdGUocl9waXBlWzFdLCBkYXRhW29mZnNldDpdKQoKICAgICAgICAgICAgICAgICAgICAg
ICAgaWYod3IgPCAwKToKICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAxCgogICAg
ICAgICAgICAgICAgICAgICAgICB3cml0ZWQgKz0gd3IKICAgICAgICAgICAgICAgICAgICAgICAg
b2Zmc2V0ICs9IHdyCgogICAgICAgICAgICAgICAgZWxzZToKICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gLTEgICAgICAgICAgICAgIAo=
--001a113a73740549b4050b57c53a--
