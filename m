From: =?UTF-8?Q?Florian_Sch=C3=BCller?= <florian.schueller@gmail.com>
Subject: [PATCH] Gitk Inotify support
Date: Thu, 9 Jun 2016 23:12:13 +0200
Message-ID: <CAHdOBFrYWxfSXew5wHwcMym9=s+7cu2E9-MJJe29y+3zV89x7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0149359e6fafa90534dee10e
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 23:13:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7Fn-0007hZ-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbcFIVMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:12:35 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38479 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcFIVMf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:12:35 -0400
Received: by mail-wm0-f42.google.com with SMTP id m124so76887995wme.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=WWSSVN3QY9a3L8DaumCpOzlxhSdoqiyQgt9EF6X3Mf4=;
        b=bNZ5GLB9s3HePE171RbEYc1mMJkrr8QkABeEpf9hB/Hsbk/JBcd6yvdFia1TKeOav2
         XokUufNGAQoaC1CjRLa1hQlj1gYDaUV58GRDXl2rknDWaiX7BYlFBhsxqJ+vnd2KMkIU
         itGkugrX/sv13SB+32YwmLgZUCPqVQunxXJKgV8QBxrMqze75aodltAI+AOnez3jSu1x
         AYgbm5fTs+nof9QMZBxP31rB7ezxUG3TP4rM7o+uUtSlm7wlesd2PmmbLmuuYowC5l64
         TExZtp7eALQLxloHASYu99qOASTOe+3bT55tyimrP6V9qn7lUI3W9pfGfxYvXVLPXz38
         ps9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WWSSVN3QY9a3L8DaumCpOzlxhSdoqiyQgt9EF6X3Mf4=;
        b=ZFjIUokvTSRuu5os6GLVqzoD/tz5eqlM2CIHpjUpClHVVTOAvyls9lFYEyLLv/qXdL
         Bh2GIidNCtw2FCvyas+kbMeGW/eHzYJJc+E2AN/KAp9uYm1Ia3JaYzWFJ4oTwXkZwXHQ
         J6njEVMx6ryQ4ccOe9yKI0HiNtfkk5Zo2hT0KwdZtUcNLaY8hh4oW3aBx0q2bvihwoYv
         hR88PX4kPQLV/SkelDmqkGn0IVQmK6X3WnytYCkAbHt2HIySmIIIXgVtnBOM1+HMlfWZ
         mlKy0Cgil8qjFnSRhEj5zcjaEkXP/3GvaAnnEZ0taWoOLmwQwNgo21qSgGT6H6LC6ats
         /LlQ==
X-Gm-Message-State: ALyK8tIhNcMWyeB725scMdzeVTnY2gRq3RGAQC87NTEKBrGQX6UIMjpQCHQOhVQJOzYcAipuXSuG5fGl9QhJ+Q==
X-Received: by 10.194.216.33 with SMTP id on1mr2016646wjc.153.1465506753099;
 Thu, 09 Jun 2016 14:12:33 -0700 (PDT)
Received: by 10.28.97.135 with HTTP; Thu, 9 Jun 2016 14:12:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296927>

--089e0149359e6fafa90534dee10e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi
Is this correct to send possible gitk patches here? or should I send
them to Paul Mackerras somehow?

Anyway I just wanted that gitk automatically updates while I'm working
in my terminal

Are you interrested?

as described in "SubmittingPatches" this patch is based on
git://ozlabs.org/~paulus/gitk   22a713c72df8b6799c59287c50cee44c4a6db51e

The code should be robust to just don't autoupdate if
https://sourceforge.net/projects/tcl-inotify/ is not installed

Open points for now:
 - release watches for deleted directories seems to cause problems in
tcl-inotify (so I don't)
   I'm not sure how often that happens in ".git/"
 - I only call "updatecommits" and I don't know if there is a usecase
where I should be calling "reloadcommits"

Regards
Florian Sch=C3=BCller

--089e0149359e6fafa90534dee10e
Content-Type: text/x-patch; charset=US-ASCII; name="0001-first-support-for-inotify.patch"
Content-Disposition: attachment; 
	filename="0001-first-support-for-inotify.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ip8sus6c0

RnJvbSA3ODVlZDZiYzFiNGEzYjkwMTlkMzUwM2IwNjZhZmIyYTAyNWEyYmMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Rmxvcmlhbj0yMFNjaD1DMz1CQ2xsZXI/PSA8
Zmxvcmlhbi5zY2h1ZWxsZXJAZ21haWwuY29tPgpEYXRlOiBUaHUsIDkgSnVuIDIwMTYgMjI6NTQ6
NDMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBmaXJzdCBzdXBwb3J0IGZvciBpbm90aWZ5CgotLS0K
IGdpdGsgfCA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDU5IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9naXRrIGIvZ2l0awppbmRleCA4MDVhMWM3Li42ZTJlYWQyIDEwMDc1NQotLS0gYS9naXRr
CisrKyBiL2dpdGsKQEAgLTgsNiArOCwxMiBAQCBleGVjIHdpc2ggIiQwIiAtLSAiJEAiCiAjIGVp
dGhlciB2ZXJzaW9uIDIsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCiAK
IHBhY2thZ2UgcmVxdWlyZSBUawordHJ5IHsKKyAgICBwYWNrYWdlIHJlcXVpcmUgaW5vdGlmeQor
ICAgIHNldCB3ZV9oYXZlX2lub3RpZnkgdHJ1ZQorfSBvbiBlcnJvciB7ZW19IHsKKyAgICBzZXQg
d2VfaGF2ZV9pbm90aWZ5IGZhbHNlCit9CiAKIHByb2MgaGFzd29ya3RyZWUge30gewogICAgIHJl
dHVybiBbZXhwciB7W2V4ZWMgZ2l0IHJldi1wYXJzZSAtLWlzLWJhcmUtcmVwb3NpdG9yeV0gPT0g
ImZhbHNlIiAmJgpAQCAtMTIzNjMsNiArMTIzNjksNTkgQEAgaWYgeyRpID49IFtsbGVuZ3RoICRh
cmd2XSAmJiAkcmV2dHJlZWFyZ3MgbmUge319IHsKICAgICB9CiB9CiAKK3Byb2MgaW5vdGlmeV9o
YW5kbGVyIHsgZmQgfSB7CisgICAgc2V0IGV2ZW50cyBbaW5vdGlmeV93YXRjaCByZWFkXQorICAg
IHNldCB3YXRjaF9pbmZvIFtpbm90aWZ5X3dhdGNoIGluZm9dCisgICAgc2V0IHVwZGF0ZV92aWV3
IGZhbHNlCisKKyAgICBmb3JlYWNoIHtldmVudH0gJGV2ZW50cyB7CisgICAgICAgIHNldCBjdXJy
ZW50X3dhdGNoaWQgW2RpY3QgZ2V0ICRldmVudCB3YXRjaGlkXQorICAgICAgICBzZXQgZmxhZ3Mg
W2RpY3QgZ2V0ICRldmVudCBmbGFnc10KKyAgICAgICAgc2V0IGV2ZW50X2ZpbGVuYW1lIFtkaWN0
IGdldCAkZXZlbnQgZmlsZW5hbWVdCisKKyAgICAgICAgZm9yZWFjaCB7cGF0aCB3YXRjaGlkIHdh
dGNoX2ZsYWdzfSAkd2F0Y2hfaW5mbyB7CisgICAgICAgICAgICBpZiB7JHdhdGNoaWQgZXEgJGN1
cnJlbnRfd2F0Y2hpZH0geworICAgICAgICAgICAgICAgIHNldCB3YXRjaF9wYXRoICRwYXRoCisg
ICAgICAgICAgICB9CisgICAgICAgIH0KKworICAgICAgICBzZXQgZnVsbF9maWxlbmFtZSBbZmls
ZSBqb2luICR3YXRjaF9wYXRoICRldmVudF9maWxlbmFtZV0KKworIyAgICAgICAgcmVtb3ZlIGRv
ZXMgbm90IHNlZW0gdG8gd29yaworIyAgICAgICAgaWYgeyRmbGFncyBlcSAicyJ9IHsKKyMgICAg
ICAgICAgICBwdXRzICJSZW1vdmUgd2F0Y2ggJGZ1bGxfZmlsZW5hbWUiCisjICAgICAgICAgICAg
c2V0IHdkIFtpbm90aWZ5X3dhdGNoIHJlbW92ZSAkZnVsbF9maWxlbmFtZV0KKyMgICAgICAgIH0K
KworICAgICAgICBpZiB7JGZsYWdzIGVxICJuRCJ9IHsKKyAgICAgICAgICAgIHNldCB3ZCBbaW5v
dGlmeV93YXRjaCBhZGQgJGZ1bGxfZmlsZW5hbWUgIm53ZHMiXQorICAgICAgICB9CisgICAgICAg
IGlmIHshW3N0cmluZyBtYXRjaCAqLmxvY2sgJGV2ZW50X2ZpbGVuYW1lXX0geworICAgICAgICAg
ICAgc2V0IHVwZGF0ZV92aWV3IHRydWUKKyAgICAgICAgfQorICAgIH0KKworICAgICNyZWxvYWRj
b21taXRzIG9yIHVwZGF0ZWNvbW1pdHMgLSBkZXBlbmRpbmcgb24gZmlsZSBhbmQgb3BlcmF0aW9u
PworICAgIGlmIHskdXBkYXRlX3ZpZXd9IHsKKyAgICAgICAgdXBkYXRlY29tbWl0cworICAgIH0K
K30KKworcHJvYyB3YXRjaF9yZWN1cnNpdmUgeyBkaXIgfSB7CisgICAgaW5vdGlmeV93YXRjaCBh
ZGQgJGRpciAibndhQ21NZHMiCisKKyAgICBmb3JlYWNoIGkgW2dsb2IgLW5vY29tcGxhaW4gLWRp
ciAkZGlyICpdIHsKKyAgICAgICAgaWYge1tmaWxlIHR5cGUgJGldIGVxIHtkaXJlY3Rvcnl9fSB7
CisgICAgICAgICAgICB3YXRjaF9yZWN1cnNpdmUgJGkKKyAgICAgICAgfQorICAgIH0KK30KKwor
aWYgeyAkd2VfaGF2ZV9pbm90aWZ5IH0geworICAgIHNldCBmZCBbaW5vdGlmeSBjcmVhdGUgImlu
b3RpZnlfd2F0Y2giICI6Omlub3RpZnlfaGFuZGxlciJdCisgICAgd2F0Y2hfcmVjdXJzaXZlICRn
aXRkaXIKK30KKwogc2V0IG51bGxpZCAiMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMCIKIHNldCBudWxsaWQyICIwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAxIgogc2V0IG51bGxmaWxlICIvZGV2L251bGwiCi0tIAoyLjcuNAoK
--089e0149359e6fafa90534dee10e--
