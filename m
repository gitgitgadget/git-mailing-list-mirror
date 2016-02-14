From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Custom merge driver with no rename detection
Date: Sun, 14 Feb 2016 17:51:10 -0200
Message-ID: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113f91b6cf03cb052bc03826
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 20:51:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV2hS-0007LR-3E
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 20:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbcBNTvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2016 14:51:12 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34044 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbcBNTvL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 14:51:11 -0500
Received: by mail-io0-f176.google.com with SMTP id 9so140381237iom.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=XdAyEnyCD/PG7G4en47qnmeNaqiWb4WFvO8hNkGyZX8=;
        b=Q+QkOx8ydhvQR9h5IKLjjK/UI/aFPCyhOTJi12iMLCixrC7r9lVf/Ta73+xT9Sg6uM
         scTxz3LEVTXo5HKtD9HrvcNyDhFDAbXMcGBUa9lWPNKB247v1gPj9AFLlEGpTRG3hhoe
         6vkMk7FEYeH9RAjGthbkDRy9Uhvvg+635uQuyfxkvt86apZ7luL5Gzg4q1TxCRQh8Vjm
         eQcaHliyNsdbR2IMhn0q4oZwsEsRHhw+WGTDN+olDDgfOXG+ObAnPeBr40Z7aH5RBde6
         LTb+IgtQdQKnLVS0gL87BgNRas7CMMhep5SSU30BUJsiq8Ezb0KF8iQXwdfVYN9YVpa/
         Je8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=XdAyEnyCD/PG7G4en47qnmeNaqiWb4WFvO8hNkGyZX8=;
        b=F+iJD2jhCyucuEsNYTD0aV0GHEW+P1Z5/y/NpHn5IyFSTsfUHvsjhLWPDPl0ZxW73x
         +G+R0L5XmQkyfXkcO1yOYbj55Hat+WM1UCVOph0TdIB/1esAH+GxDTrYWs5m9DlJ2J97
         yLwaaxs1rOOD5zHXV1ysJSgc3CG1k9uEnL8NKWUqMfxMnWX7qU7DS3ny7+sgO5IWjl78
         GLSkK1wT9pYDG81sgPpsihTvwW2K7yRyVCz9f2CnrXR+0Y+oNSQgdQT6EHwywT/VqAUv
         g3ZRumeQeWjAuV74IAriohYHZDssQG8OL45YiZxT/enD4AuA7q02bm0CTNsAXdJ2gCyt
         T13A==
X-Gm-Message-State: AG10YOTLXyrlz1wgo+AU8WQtxbrh7vDS1PtRKnMAYJRm2jF6OaJHYNrnbUpKgNMpxzsMhJSNeUXsPW67Pa20og==
X-Received: by 10.107.19.193 with SMTP id 62mr15731678iot.41.1455479470342;
 Sun, 14 Feb 2016 11:51:10 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Sun, 14 Feb 2016 11:51:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286161>

--001a113f91b6cf03cb052bc03826
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to set up a Git repository with a custom merge driver,
and then disable rename detection when merging.

Unfortunately, the recursive strategy has no "no-renames" option. Note
that I would like to avoid rename detection even when the file
contents perfectly match.

The usual workaround is using the resolve strategy, but apparently it
ignores the custom merge driver. Besides, I would really like to use
the recursive strategy logic.

Is there any solution to this in the current version?

If not, what do you think about adding a "no-renames" option to the
recursive strategy? I could work on a patch.

Attached is a quick and dirty patch that emulates the effect by
allowing greater than 100% rename thresholds to mean "no-renames".

And here is a related question on StackOverflow:
http://stackoverflow.com/questions/35135517/custom-git-merge-driver-with-no=
-rename-detection

Thanks in advance for any attention provided.

Regards,
Felipe Gon=C3=A7alves Assis

--001a113f91b6cf03cb052bc03826
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-diff-rename-threshold-above-100-means-no-renames.patch"
Content-Disposition: attachment; 
	filename="0001-diff-rename-threshold-above-100-means-no-renames.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ikmyobsi0

RnJvbSBiY2VmNmM0NGZhYzNhMjlhZmUwMzQwOGVmMjcwMjQ3NzZkYTg2MWVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/RmVsaXBlPTIwR29uPUMzPUE3YWx2ZXM9MjBB
c3Npcz89IDxmZWxpcGVnYXNzaXNAZ21haWwuY29tPgpEYXRlOiBTdW4sIDE0IEZlYiAyMDE2IDE3
OjAyOjAwIC0wMjAwClN1YmplY3Q6IFtQQVRDSF0gZGlmZjogcmVuYW1lIHRocmVzaG9sZCBhYm92
ZSAxMDAlIG1lYW5zIG5vIHJlbmFtZXMKCi0tLQogZGlmZi5jICAgICAgICAgICAgfCAyICstCiBk
aWZmY29yZS1yZW5hbWUuYyB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RpZmYuYyBiL2RpZmYuYwppbmRleCAyMTM2
YjY5Li40M2I5ZTBhIDEwMDY0NAotLS0gYS9kaWZmLmMKKysrIGIvZGlmZi5jCkBAIC00MDAzLDcg
KzQwMDMsNyBAQCBpbnQgcGFyc2VfcmVuYW1lX3Njb3JlKGNvbnN0IGNoYXIgKipjcF9wKQogCS8q
IHVzZXIgc2F5cyBudW0gZGl2aWRlZCBieSBzY2FsZSBhbmQgd2Ugc2F5IGludGVybmFsbHkgdGhh
dAogCSAqIGlzIE1BWF9TQ09SRSAqIG51bSAvIHNjYWxlLgogCSAqLwotCXJldHVybiAoaW50KSgo
bnVtID49IHNjYWxlKSA/IE1BWF9TQ09SRSA6IChNQVhfU0NPUkUgKiBudW0gLyBzY2FsZSkpOwor
CXJldHVybiAoaW50KShNQVhfU0NPUkUgKiBudW0gLyBzY2FsZSk7CiB9CiAKIHN0YXRpYyBpbnQg
ZGlmZl9zY29yZW9wdF9wYXJzZShjb25zdCBjaGFyICpvcHQpCmRpZmYgLS1naXQgYS9kaWZmY29y
ZS1yZW5hbWUuYyBiL2RpZmZjb3JlLXJlbmFtZS5jCmluZGV4IGFmMWZlMDguLjdjYjVhM2IgMTAw
NjQ0Ci0tLSBhL2RpZmZjb3JlLXJlbmFtZS5jCisrKyBiL2RpZmZjb3JlLXJlbmFtZS5jCkBAIC00
OTcsNyArNDk3LDcgQEAgdm9pZCBkaWZmY29yZV9yZW5hbWUoc3RydWN0IGRpZmZfb3B0aW9ucyAq
b3B0aW9ucykKIAkJCXJlZ2lzdGVyX3JlbmFtZV9zcmMocCk7CiAJCX0KIAl9Ci0JaWYgKHJlbmFt
ZV9kc3RfbnIgPT0gMCB8fCByZW5hbWVfc3JjX25yID09IDApCisJaWYgKHJlbmFtZV9kc3RfbnIg
PT0gMCB8fCByZW5hbWVfc3JjX25yID09IDAgfHwgbWluaW11bV9zY29yZSA+IE1BWF9TQ09SRSkK
IAkJZ290byBjbGVhbnVwOyAvKiBub3RoaW5nIHRvIGRvICovCiAKIAkvKgotLSAKMi43LjEuMjg3
Lmc0OTQzOTg0Cgo=
--001a113f91b6cf03cb052bc03826--
