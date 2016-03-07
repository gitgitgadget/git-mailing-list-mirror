From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Mon, 07 Mar 2016 13:11:14 -0800
Message-ID: <xmqqlh5ungct.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 22:11:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad2R0-0001GZ-A1
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 22:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbcCGVLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 16:11:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753309AbcCGVLS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 16:11:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C5904B363;
	Mon,  7 Mar 2016 16:11:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kn/YRm3MGCbP8yQM/DqQsJ+J7jI=; b=luGwwC
	u6tcaVns4aiE0hw/FkQLib25SYMOmuv/F5j7PCfPx4oKhEM35sYwoJqaWQy7/QrY
	aWVnZp+IhLhz2lDdDYd02+KTNbpaNgPeXU6e1pRdsTrYiKu5O7GvoZVq04mi8EVt
	n7+3qC3RVvRi9YjlFBILuqslLspwnuXOR44aY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=io4BliZ64LAP+j/lGtn2+XuAAKuAszKo
	mJx6Np+KnWLFgsnmFS9mC1Fjgqdg3/zPz4Z+KMnB8AmywcjP+7VfxSPnNQIRG8wD
	UT5J19pEj1zv1yVhN7+cbhm4EpExBgYAapBe4szv1eQ5fUaG5tPiFaTjmfBDCEbj
	UaMan5+lPFE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 948194B362;
	Mon,  7 Mar 2016 16:11:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 151A54B361;
	Mon,  7 Mar 2016 16:11:16 -0500 (EST)
In-Reply-To: <CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 5 Mar 2016 07:43:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 211FE08C-E4A9-11E5-9C94-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288401>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 5, 2016 at 12:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Are we good at 2.8.0-rc0, too?  Somehow I had an impression that we
>> queued "another attempt to do it differently" or something.
>>
>>  ... goes and looks ...
>>
>>     $ rungit maint status -suall
>>     ?? baz/quux/corge/wibble.txt
>>     ?? baz/quux/grault.txt
>>     ?? foo/bar.txt
>>     $ rungit master status -suall
>>     ?? baz/quux/corge/wibble.txt
>>     ?? baz/quux/grault.txt
>>     ?? baz/waldo.txt
>>     ?? foo/bar.txt
>>     ?? foo/garply.txt
> ...
> the decision is not taken earlier from line "!/baz" and it's decided
> to be re-included. Which I would argue is the correct thing because
> you ask to re-include the whole directory "baz". It should behave this
> way because exclude rules without '!' behave this way.

We need documentation update to settle this one before 2.8 final
ships, as we seem to be seeing more and more end-user confusion on
the list.  I tried to come up with a trimmed-down example, which is
shown below, but I suspect that the code is not exactly working the
way it is described in that (1) dir/file1 is ignored and (3)
!dir/file3 entry makes difference.

Where did my example go wrong?

FYI, if I prefix '/' to all the .gitignore entries in the example, i.e.
making it

    *
    !/dir
    /dir/file2
    !/dir/file3

instead, then dir/file1 and dir/file3 do get shown as unignored.

If it is documented somewhere, then I can update the example and
declare victory (but then the text that accompanies the example
still needs to remind the readers why the leading '/' matters.

Thanks.



 Documentation/gitignore.txt | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 3ded6fd..b841233 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -150,6 +150,40 @@ excluded, the following conditions must be met:
  - The directory part in the re-include rules must be literal (i.e. no
    wildcards)
 
+A re-inclusion of a directory makes all files in the directory
+unignored.  For example, suppose you have files `.gitignore`,
+`dir/file1`, `dir/file2`, and `dir/file3`, and have the following in
+your `.gitignore`:
+
+----------------
+*
+!dir
+# dir/file1 is not mentioned in .gitignore
+dir/file2
+!dir/file3
+----------------
+
+Then:
+
+ - `.gitignore` gets ignored, because it matches the `*` at the top
+   level;
+
+ - `dir/file1` gets unignored, because `dir` marks everything
+   underneath `dir/` to be unignored unless otherwise specified;
+
+ - `dir/file2` gets ignored, because `dir/file2` is listed to be
+   ignored;
+
+ - `dir/file3` gets unignored, because `dir/file3` is listed to be
+   ignored.  Note that the entry `!dir/file3` is redundant because
+   everything underneath `dir/` is marked to be unignored already.
+
+Some earlier versions of Git treated `!dir` differently in that it
+did not cause the paths under it unignored, but this has been
+corrected to be consistent with `dir` that says "`dir` and everything
+below are ignored."
+
+
 EXAMPLES
 --------
 
