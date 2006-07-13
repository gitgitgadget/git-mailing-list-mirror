From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: remove perl from git-commit.sh
Date: Thu, 13 Jul 2006 10:30:43 +0200
Message-ID: <81b0412b0607130130n52a25d91wd8476ad8d018623f@mail.gmail.com>
References: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
	 <7v3bd6xgnz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7671_10869439.1152779443267"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 10:31:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0wau-0000dv-IP
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 10:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWGMIap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 04:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWGMIap
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 04:30:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:5037 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932436AbWGMIap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 04:30:45 -0400
Received: by nf-out-0910.google.com with SMTP id n29so99784nfc
        for <git@vger.kernel.org>; Thu, 13 Jul 2006 01:30:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=TQvzUik97wSrbOuSR9b5tfCctz8joL303MVU8A6VXCXD3sPDkG7+qiDM3pC3NFgxdPpF9D74k32Y/msNhNGMT0rc+D+fI++pUHd+msz+oCtP32jbqsb1CLMuok6swpB7qC+Yf1Vvo5AGDNy3L2qRVP3OwOT3S5RNgJ4atzO7xfo=
Received: by 10.78.165.16 with SMTP id n16mr370567hue;
        Thu, 13 Jul 2006 01:30:43 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Thu, 13 Jul 2006 01:30:43 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v3bd6xgnz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23824>

------=_Part_7671_10869439.1152779443267
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

git-commit.sh has the only one place where perl is used
and there it can quite trivially be done in sh.

git-ls-files without "-z" produces quoted output, even if
is different from that produced by perl code it could be
enough. Otherwise I'd better suggest to add another
quoting style (replacing only \t, \n and backslash).

This system is an ugly combination of cygwin and
activestate perl. The combination has some quirks
(like the perl producing \r\n by default, expecting
windows pathnames instead of cygwin fakes, or
ignoring environment variables under some hard to
reproduce circumstances), so reducing number of
this interactions reduces number of hacks one has
to put in core code to make things work. I used to
patch git-commit.sh to put binmode in perl output,
and git-clone.sh still has these calls to cygpath.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

It is really annoying when the essentials do not work.
I think we could improve at  least them, by minimizing
their dependencies to external tools.

Junio C Hamano wrote:
> (1) Sign-off?

done

> (2) I think the cover letter comment talks more apporpirate
>    things than your proposed commit message.  The commit log is
>    not a place to vent your frustration.  It's where you
>    justify why that change was needed for people who will want
>    to figure out why your patch broke their workflow later.

done.

------=_Part_7671_10869439.1152779443267
Content-Type: text/plain; name=0001-remove-perl-from-git-commit.sh.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_epktwtn9
Content-Disposition: attachment; filename="0001-remove-perl-from-git-commit.sh.txt"

RnJvbSA2OWJmNDFkZjRlZjY5ZDBmMWU0YWI1Mjk0MmM1OWJiM2ZkNTY4Y2I4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDEyIEp1bCAyMDA2IDEzOjAyOjIzICswMjAwClN1YmplY3Q6IHJlbW92ZSBwZXJsIGZy
b20gZ2l0LWNvbW1pdC5zaAotLS0KIGdpdC1jb21taXQuc2ggfCAgIDMyICsrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE5
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1jb21taXQuc2ggYi9naXQtY29tbWl0LnNo
CmluZGV4IDgwMmRkNzIuLjRjZjNmYWIgMTAwNzU1Ci0tLSBhL2dpdC1jb21taXQuc2gKKysrIGIv
Z2l0LWNvbW1pdC5zaApAQCAtMTM4LDMyICsxMzgsMjYgQEAgIycKICAgICAgICAgaWYgdGVzdCAt
eiAiJHVudHJhY2tlZF9maWxlcyI7IHRoZW4KICAgICAgICAgICAgIG9wdGlvbj0iLS1kaXJlY3Rv
cnkgLS1uby1lbXB0eS1kaXJlY3RvcnkiCiAgICAgICAgIGZpCisJaGRyX3Nob3duPQogCWlmIHRl
c3QgLWYgIiRHSVRfRElSL2luZm8vZXhjbHVkZSIKIAl0aGVuCi0JICAgIGdpdC1scy1maWxlcyAt
eiAtLW90aGVycyAkb3B0aW9uIFwKKwkgICAgZ2l0LWxzLWZpbGVzIC0tb3RoZXJzICRvcHRpb24g
XAogCQktLWV4Y2x1ZGUtZnJvbT0iJEdJVF9ESVIvaW5mby9leGNsdWRlIiBcCiAJCS0tZXhjbHVk
ZS1wZXItZGlyZWN0b3J5PS5naXRpZ25vcmUKIAllbHNlCi0JICAgIGdpdC1scy1maWxlcyAteiAt
LW90aGVycyAkb3B0aW9uIFwKKwkgICAgZ2l0LWxzLWZpbGVzIC0tb3RoZXJzICRvcHRpb24gXAog
CQktLWV4Y2x1ZGUtcGVyLWRpcmVjdG9yeT0uZ2l0aWdub3JlCiAJZmkgfAotCUBAUEVSTEBAIC1l
ICckLyA9ICJcMCI7Ci0JICAgIG15ICRzaG93biA9IDA7Ci0JICAgIHdoaWxlICg8PikgewotCQlj
aG9tcDsKLQkJc3xcXHxcXFxcfGc7Ci0JCXN8XHR8XFx0fGc7Ci0JCXN8XG58XFxufGc7Ci0JCXMv
Xi8jCS87Ci0JCWlmICghJHNob3duKSB7Ci0JCSAgICBwcmludCAiI1xuIyBVbnRyYWNrZWQgZmls
ZXM6XG4iOwotCQkgICAgcHJpbnQgIiMgICAodXNlIFwiZ2l0IGFkZFwiIHRvIGFkZCB0byBjb21t
aXQpXG4iOwotCQkgICAgcHJpbnQgIiNcbiI7Ci0JCSAgICAkc2hvd24gPSAxOwotCQl9Ci0JCXBy
aW50ICIkX1xuIjsKLQkgICAgfQotCScKKwl3aGlsZSByZWFkIGxpbmU7IGRvCisJICAgIGlmIFsg
LXogIiRoZHJfc2hvd24iIF07IHRoZW4KKwkJZWNobyAnIycKKwkJZWNobyAnIyBVbnRyYWNrZWQg
ZmlsZXM6JworCQllY2hvICcjICAgKHVzZSAiZ2l0IGFkZCIgdG8gYWRkIHRvIGNvbW1pdCknCisJ
CWVjaG8gJyMnCisJCWhkcl9zaG93bj0xCisJICAgIGZpCisJICAgIGVjaG8gIiMJJGxpbmUiCisJ
ZG9uZQogCiAJaWYgdGVzdCAtbiAiJHZlcmJvc2UiIC1hIC16ICIkSVNfSU5JVElBTCIKIAl0aGVu
Ci0tIAoxLjQuMS5nYjRhZGYKCg==
------=_Part_7671_10869439.1152779443267--
