From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [TOY PATCH]: rebase: Add --show-files option
Date: Fri, 3 Oct 2014 12:42:14 +0800
Message-ID: <CAEY4ZpN4HEo-Csf1UjpGX4YLKWRrywinUemeZFZdVg=ZtTsaqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1135ea7265d5bd05047d5b61
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 06:42:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZuhA-0005Dq-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 06:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbaJCEmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 00:42:16 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:38616 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbaJCEmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 00:42:16 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so367713lbd.29
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 21:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+7456VvWcF4MmonAG+RLham9Wu8nG9S4ofQQlai6Ks8=;
        b=dIqB8Lkd+IYJ9mTbYVQtDcDxW/AckGf/zmDDMTU6eGqM0hGFHwzvrkAV3zpXo9I8MG
         egYC3x85WaY5TneXxQnfEj4WrrXqtQuoGnm1dQC3HBNJSuzFFt02fGRpLYKSaf+1HYNY
         olgc6KVxkELq/boaJ5l6XlqAwh6p3KH1hAJMwPk3cJGei9GJ9y0R0WCL2x3PW+O9Eng6
         vDyEFLZP4aVTcc63WpvHEfPRuEA1WivMUUMVgLfTxpyYhvXTizJXN/rPtp9I/8o2a+m3
         gpHfLP7Upyo+Bdf3XKoB8893M5+rJkC4MsYO8XFE7g4zr8hfxx1QpTfo0pWdGb1AkS9/
         jLVg==
X-Received: by 10.112.9.234 with SMTP id d10mr553536lbb.98.1412311334368; Thu,
 02 Oct 2014 21:42:14 -0700 (PDT)
Received: by 10.112.13.35 with HTTP; Thu, 2 Oct 2014 21:42:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257830>

--001a1135ea7265d5bd05047d5b61
Content-Type: text/plain; charset=UTF-8

Hi,

When working on a "new feature branch" that touches a lot of files I
tend to make commits that affect only single files, and for very small
changes. Since at this stage I'm experimentating a lot - trying out
ideas, etc. - the commits tend to grow a lot (could be 50-70
individual commits, each modifying one or two files), and I don't
think much about the commit message beside making a one-liner that
explains only the gist.

Most of the times I include the filename in the commit message to help
me identify which commits should be squashed together later.

Only when the feature seems to be functional that I git rebase the
commits in order to shape the history into its final, proper form.

When rebasing these upwards of 40+ commits, it is helpful if the
rebase instruction sheet shows me the actual files that the commits
affect so I made this patch (sorry I couldn't attach it inline since
gmail eats all the tabs) that adds the "--show-files" option to
git-rebase to achieve something to this effect:

pick 996fa59 Remove autoconf submodule
     # :100644 100644 cfc8a25... 28ddb02... M   .gitmodules
     # :160000 000000 0263a9f... 0000000... D   autoconf
... more pick lines
pick 4c5070f Remove automake submodule
     # :100644 100644 28ddb02... f907328... M   .gitmodules
     # :160000 000000 9042530... 0000000... D   automake

Having the list of files shown below each commit, indented to reduce
cluttering the "pick" instruction, really does help in deciding the
reorder and squash candidates.

The files list came from this:

  git show --raw $sha1|awk '/^:/ {print " '"${comment_char}"'\t"$0}'

Thoughts?

nazri

--001a1135ea7265d5bd05047d5b61
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-rebase-Add-show-files-option.patch"
Content-Disposition: attachment; 
	filename="0001-rebase-Add-show-files-option.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i0t1m3uv0

RnJvbSA0ODI2ODc1YzE0NTU0ZDRmYTUwOThkZGY5NDk5YzMzY2I3YjkwMDFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYXpyaSBSYW1saXkgPGF5aWVoZXJlQGdtYWlsLmNvbT4KRGF0
ZTogRnJpLCAzIE9jdCAyMDE0IDA5OjU5OjM4ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcmViYXNl
OiBBZGQgLS1zaG93LWZpbGVzIG9wdGlvbgoKLS0tCiBEb2N1bWVudGF0aW9uL2dpdC1yZWJhc2Uu
dHh0IHwgIDggKysrKysrKysKIGdpdC1yZWJhc2UtLWludGVyYWN0aXZlLnNoICAgfCAxMyArKysr
KysrKysrKysrCiBnaXQtcmViYXNlLnNoICAgICAgICAgICAgICAgIHwgIDUgKysrKysKIDMgZmls
ZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
Z2l0LXJlYmFzZS50eHQgYi9Eb2N1bWVudGF0aW9uL2dpdC1yZWJhc2UudHh0CmluZGV4IGYxNDEw
MGEuLjQ5OTZiYzQgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZ2l0LXJlYmFzZS50eHQKKysr
IGIvRG9jdW1lbnRhdGlvbi9naXQtcmViYXNlLnR4dApAQCAtMzgzLDYgKzM4MywxNCBAQCBJZiBg
LS1hdXRvc3F1YXNoYCBpcyB1c2VkLCAiZXhlYyIgbGluZXMgd2lsbCBub3QgYmUgYXBwZW5kZWQg
Zm9yCiB0aGUgaW50ZXJtZWRpYXRlIGNvbW1pdHMsIGFuZCB3aWxsIG9ubHkgYXBwZWFyIGF0IHRo
ZSBlbmQgb2YgZWFjaAogc3F1YXNoL2ZpeHVwIHNlcmllcy4KIAorLUY6OgorLS1zaG93LWZpbGVz
OjoKKwlBcHBlbmQgdGhlIGxpc3Qgb2YgYWZmZWN0ZWQgZmlsZXMgYWZ0ZXIgZWFjaCBsaW5lIGNy
ZWF0aW5nIGEgY29tbWl0IGluCisJdGhlIGhpc3RvcnkuCisrCitUaGlzIG9wdGlvbiBjYW4gb25s
eSBiZSB1c2VkIHdpdGggdGhlIGAtLWludGVyYWN0aXZlYCBvcHRpb24KKyhzZWUgSU5URVJBQ1RJ
VkUgTU9ERSBiZWxvdykuCisKIC0tcm9vdDo6CiAJUmViYXNlIGFsbCBjb21taXRzIHJlYWNoYWJs
ZSBmcm9tIDxicmFuY2g+LCBpbnN0ZWFkIG9mCiAJbGltaXRpbmcgdGhlbSB3aXRoIGFuIDx1cHN0
cmVhbT4uICBUaGlzIGFsbG93cyB5b3UgdG8gcmViYXNlCmRpZmYgLS1naXQgYS9naXQtcmViYXNl
LS1pbnRlcmFjdGl2ZS5zaCBiL2dpdC1yZWJhc2UtLWludGVyYWN0aXZlLnNoCmluZGV4IGI2NGRk
MjguLjMyYjQyNjYgMTAwNjQ0Ci0tLSBhL2dpdC1yZWJhc2UtLWludGVyYWN0aXZlLnNoCisrKyBi
L2dpdC1yZWJhc2UtLWludGVyYWN0aXZlLnNoCkBAIC04MjAsNiArODIwLDExIEBAIGFkZF9leGVj
X2NvbW1hbmRzICgpIHsKIAltdiAiJDEubmV3IiAiJDEiCiB9CiAKK3ByaW50X2FmZmVjdGVkX2Zp
bGVzICgpIHsKKwljb21taXRfc2hhMT0iJDEiCisJZ2l0IHNob3cgLS1yYXcgJGNvbW1pdF9zaGEx
fGF3ayAnL146LyB7cHJpbnQgIiAgICAgJyIke2NvbW1lbnRfY2hhcn0iJyAiJDB9JworfQorCiAj
IFRoZSB3aG9sZSBjb250ZW50cyBvZiB0aGlzIGZpbGUgaXMgcnVuIGJ5IGRvdC1zb3VyY2luZyBp
dCBmcm9tCiAjIGluc2lkZSBhIHNoZWxsIGZ1bmN0aW9uLiAgSXQgdXNlZCB0byBiZSB0aGF0ICJy
ZXR1cm4icyB3ZSBzZWUKICMgYmVsb3cgd2VyZSBub3QgaW5zaWRlIGFueSBmdW5jdGlvbiwgYW5k
IGV4cGVjdGVkIHRvIHJldHVybgpAQCAtOTc4LDYgKzk4MywxMCBAQCBkbwogCWlmIHRlc3QgdCAh
PSAiJHByZXNlcnZlX21lcmdlcyIKIAl0aGVuCiAJCXByaW50ZiAnJXNcbicgIiR7Y29tbWVudF9v
dXR9cGljayAkc2hvcnRzaGExICRyZXN0IiA+PiIkdG9kbyIKKwkJaWYgdGVzdCAtbiAiJHNob3df
ZmlsZXMiCisJCXRoZW4KKwkJCXByaW50X2FmZmVjdGVkX2ZpbGVzICRzaG9ydHNoYTEgPj4gIiR0
b2RvIgorCQlmaQogCWVsc2UKIAkJc2hhMT0kKGdpdCByZXYtcGFyc2UgJHNob3J0c2hhMSkKIAkJ
aWYgdGVzdCAteiAiJHJlYmFzZV9yb290IgpAQCAtOTk3LDYgKzEwMDYsMTAgQEAgZG8KIAkJdGhl
bgogCQkJdG91Y2ggIiRyZXdyaXR0ZW4iLyRzaGExCiAJCQlwcmludGYgJyVzXG4nICIke2NvbW1l
bnRfb3V0fXBpY2sgJHNob3J0c2hhMSAkcmVzdCIgPj4iJHRvZG8iCisJCQlpZiB0ZXN0IC1uICIk
c2hvd19maWxlcyIKKwkJCXRoZW4KKwkJCQlwcmludF9hZmZlY3RlZF9maWxlcyAkc2hhMSA+PiAi
JHRvZG8iCisJCQlmaQogCQlmaQogCWZpCiBkb25lCmRpZmYgLS1naXQgYS9naXQtcmViYXNlLnNo
IGIvZ2l0LXJlYmFzZS5zaAppbmRleCA1NWRhOWRiLi40OTY4YjJjIDEwMDc1NQotLS0gYS9naXQt
cmViYXNlLnNoCisrKyBiL2dpdC1yZWJhc2Uuc2gKQEAgLTI0LDYgKzI0LDcgQEAgbSxtZXJnZSEg
ICAgICAgICAgIHVzZSBtZXJnaW5nIHN0cmF0ZWdpZXMgdG8gcmViYXNlCiBpLGludGVyYWN0aXZl
ISAgICAgbGV0IHRoZSB1c2VyIGVkaXQgdGhlIGxpc3Qgb2YgY29tbWl0cyB0byByZWJhc2UKIHgs
ZXhlYz0hICAgICAgICAgICBhZGQgZXhlYyBsaW5lcyBhZnRlciBlYWNoIGNvbW1pdCBvZiB0aGUg
ZWRpdGFibGUgbGlzdAogayxrZWVwLWVtcHR5CSAgIHByZXNlcnZlIGVtcHR5IGNvbW1pdHMgZHVy
aW5nIHJlYmFzZQorRixzaG93LWZpbGVzICAgICAgIFNob3cgZmlsZXMgYWZmZWN0ZWQgYnkgZWFj
aCBsaXN0IG9mIGNvbW1pdCB0byByZWJhc2UKIGYsZm9yY2UtcmViYXNlISAgICBmb3JjZSByZWJh
c2UgZXZlbiBpZiBicmFuY2ggaXMgdXAgdG8gZGF0ZQogWCxzdHJhdGVneS1vcHRpb249ISBwYXNz
IHRoZSBhcmd1bWVudCB0aHJvdWdoIHRvIHRoZSBtZXJnZSBzdHJhdGVneQogc3RhdCEgICAgICAg
ICAgICAgIGRpc3BsYXkgYSBkaWZmc3RhdCBvZiB3aGF0IGNoYW5nZWQgdXBzdHJlYW0KQEAgLTg4
LDYgKzg5LDcgQEAgYXV0b3NxdWFzaD0KIGtlZXBfZW1wdHk9CiB0ZXN0ICIkKGdpdCBjb25maWcg
LS1ib29sIHJlYmFzZS5hdXRvc3F1YXNoKSIgPSAidHJ1ZSIgJiYgYXV0b3NxdWFzaD10CiBncGdf
c2lnbl9vcHQ9CitzaG93X2ZpbGVzPQogCiByZWFkX2Jhc2ljX3N0YXRlICgpIHsKIAl0ZXN0IC1m
ICIkc3RhdGVfZGlyL2hlYWQtbmFtZSIgJiYKQEAgLTMzNiw2ICszMzgsOSBAQCBkbwogCS0tZ3Bn
LXNpZ249KikKIAkJZ3BnX3NpZ25fb3B0PSItUyR7MSMtLWdwZy1zaWduPX0iCiAJCTs7CisJIC0t
c2hvdy1maWxlc3wtRikKKwkJc2hvd19maWxlcz10CisJCTs7CiAJLS0pCiAJCXNoaWZ0CiAJCWJy
ZWFrCi0tIAoyLjEuMC4yNDQuZzU3OTY0NjcuZGlydHkKCg==
--001a1135ea7265d5bd05047d5b61--
