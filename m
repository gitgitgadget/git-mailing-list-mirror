From: Alif Wahid <alif.wahid@gmail.com>
Subject: Git exhausts memory.
Date: Sat, 2 Apr 2011 16:01:59 +1100
Message-ID: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3071c7f6280d45049fe86dbc
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 07:02:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5syO-00080u-Df
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 07:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab1DBFCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 01:02:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60266 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab1DBFCA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 01:02:00 -0400
Received: by vws1 with SMTP id 1so3176610vws.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 22:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=hSCiz5ZiymXN9XQFWXxOG2LlIRdlXOrGIypQ9b6jZcs=;
        b=TPBspxopRYt2RCpuTcrXWbY4kScsJCplUTfWzaszi5Rq/X/e8IjY0QUEmOyydiDs8X
         82qC6u0p+qKHUEqyhEoPb5lS9dg1JBJDKzuv6Gj4rsBqeJsNFvrY5fe+YPtzHrzeSEk3
         FwMVF3rqUTl2nWItAOXXHn388odmEPQ10MKX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=E38wqDS6FOMiHvRGe39KR84grjQMOitetbJR0nHQVvQdyEVXgBPwx8iZ6ifw0rmMp4
         72L/t9CDg8m55s7OTOtqI18OSFyGzyr1Yf4fO/eIlOXlpAYgNzIWEV4Cmm7Vnfq0YJ6T
         BdEKXuBwPSCKwqkiir31IhtrZsMKYH0r+Wlk0=
Received: by 10.52.74.226 with SMTP id x2mr6580508vdv.264.1301720519412; Fri,
 01 Apr 2011 22:01:59 -0700 (PDT)
Received: by 10.52.155.70 with HTTP; Fri, 1 Apr 2011 22:01:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170643>

--20cf3071c7f6280d45049fe86dbc
Content-Type: text/plain; charset=UTF-8

Hi there,

I'm using Git v1.7.1 on Ubuntu v10.10 and unfortunately Git seems to
regularly exhaust the memory on my machine and fails to compress loose
objects and/or collect garbage.

My Intel based dual-core machine has 2 GB of RAM and 4 GB of swap
space. I need to track a working tree with a handful of really large
tarballs that rarely change and loads of really small text files that
change frequently. What I'm seeing is that over time whenever "git gc"
runs automatically it fails with the message "fatal: Out of memory,
malloc failed". So I've been trying to manually run "git repack -ad
--window-memory=1g --max-pack-size=1g" in the hope that Git will not
exceed the physical memory. But I still get the same error message :(

As I can't make my repository public, I've attached a simple Python
script that generates a ~1.3 GB file containing random integers (takes
roughly 10 min. on my machine). Then I run the following four commands
and get the out-of-memory failure from "git repack". This is
effectively emulating the scenario I have with my repository.

$ git init
$ git add ./test_data.dat
$ git commit ./test_data.dat -m "Test data."
$ git repack -ad --window-memory=1g --max-pack-size=1g
Counting objects: 3, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
fatal: Out of memory, malloc failed

I can't find anything on the wiki about out-of-memory failures. Any
info/help would be much appreciated.

Regards

Alif

--20cf3071c7f6280d45049fe86dbc
Content-Type: text/x-python; charset=US-ASCII; name="test_data.py"
Content-Disposition: attachment; filename="test_data.py"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gm02sh220

IyEgL3Vzci9iaW4vZW52IHB5dGhvbgoKaW1wb3J0IHN5cywgb3MsIHJhbmRvbQoKaWYgX19uYW1l
X18gPT0gJ19fbWFpbl9fJzoKCiAgICBmYnVmZiA9IDIqKjI4ICAgIyBmaWxlIGJ1ZmZlciBzaXpl
IGluIGJ5dGVzCiAgICBmaW50cyA9IDEwKio4ICAgIyBudW1iZXIgb2YgaW50ZWdlcnMgdG8gd3Jp
dGUKICAgIGZzaXplID0gMTIgICAgICAjIG51bWJlciBvZiBkaWdpdHMgdG8gd3JpdGUgcGVyIGlu
dGVnZXIKICAgIAogICAgZm5hbWUgPSBvcy5wYXRoLnNwbGl0ZXh0KG9zLnBhdGguYmFzZW5hbWUo
c3lzLmFyZ3ZbMF0pKVswXQogICAgdHJ5OgogICAgICAgIG9zLm1rZGlyKGZuYW1lKQogICAgZXhj
ZXB0IE9TRXJyb3I6CiAgICAgICAgcGFzcyAgICAjIGRpcmVjdG9yeSBhbHJlYWR5IGV4aXN0cwog
ICAgICAgIAogICAgZnBhdGggPSBvcy5wYXRoLmpvaW4oZm5hbWUsIGZuYW1lKycuZGF0JykKICAg
IGZoYW5kID0gb3BlbihmcGF0aCwgJ3cnLCBmYnVmZikKICAgIAogICAgc3lzLnN0ZG91dC53cml0
ZSgnV3JpdGluZyAlZCBNQiB0byBmaWxlIFwnJXNcJ1xuJyAlIChmaW50cyooZnNpemUrMSkvMTAq
KjYsIGZwYXRoKSkKICAgIHN5cy5zdGRvdXQud3JpdGUoJ1RoaXMgd2lsbCB0YWtlIHNvbWUgdGlt
ZSwgcGxlYXNlIHdhaXQuXG4nKQogICAgc3lzLnN0ZG91dC53cml0ZSgnUHJvZ3Jlc3M6JykKICAg
IHN5cy5zdGRvdXQuZmx1c2goKQoKICAgIHJhbmRvbS5zZWVkKC0xKQogICAgZmZvcm0gPSAnJScr
c3RyKGZzaXplKSsnZFxuJwogICAgZm9yIHggaW4geHJhbmdlKGZpbnRzKTogCiAgICAgICAgZmhh
bmQud3JpdGUoZmZvcm0gJSAocmFuZG9tLnJhbmRpbnQoMCxmaW50cykpKQogICAgICAgIGlmIHgg
JSAoZmludHMvMTApID09IDAgYW5kIHggPiAwOgogICAgICAgICAgICBzeXMuc3Rkb3V0LndyaXRl
KCclM2QvMTAnICUgKHgvKGZpbnRzLzEwKSkpIAogICAgICAgICAgICBzeXMuc3Rkb3V0LmZsdXNo
KCkKCiAgICBzeXMuc3Rkb3V0LndyaXRlKCcgMTAvMTBcbicpCiAgICBzeXMuc3Rkb3V0LmZsdXNo
KCkKICAgIGZoYW5kLmNsb3NlKCkKCg==
--20cf3071c7f6280d45049fe86dbc--
