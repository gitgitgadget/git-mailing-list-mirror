From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-push.txt: explain better cases where --force is dangerous
Date: Mon, 17 Jun 2013 14:38:47 -0700
Message-ID: <7v7ghsbeoo.fsf@alter.siamese.dyndns.org>
References: <1371491561-19117-1-git-send-email-Matthieu.Moy@imag.fr>
	<51BF7B1C.2040703@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	philipoakley@iee.org, artagnon@gmail.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 23:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoh8Z-00046M-QS
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 23:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463Ab3FQViv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 17:38:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab3FQViu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 17:38:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 028F32848D;
	Mon, 17 Jun 2013 21:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wz40WKhp1uVvDaI9nZV/LVk6kEU=; b=Kp4g2n
	YIBtk8jMr0yEXdnkx64U8f6dKfnkZ+A7W3ttge75qAk4BZJklExE1rPEBC+56Oc4
	mKDY4pnzWA3Ejh++YmseQJNou+FjfS6QCGTWIQ3EisxrPteDdOM8A0bVrfdFZWiW
	bnbvVdDXv5qc6438YMBYMuqQ5Ht8alHDbINgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMoY1BAeN2iXYOFvq+QOeHUj/1Ogfu5v
	wzq/FsIqnvFnACCPN+5K2OoUx/UyGp8RzbIS/GI31guzanUXOKXGv6xr5oss8GcB
	34FqwG+ORF62manJFXzaeCB6pJA2jFCOtVLZc8xWquqTex3g6xWmS1Ol96Wsyt78
	HzAoAGgoGS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAC872848C;
	Mon, 17 Jun 2013 21:38:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 501F22848B;
	Mon, 17 Jun 2013 21:38:49 +0000 (UTC)
In-Reply-To: <51BF7B1C.2040703@xiplink.com> (Marc Branchaud's message of "Mon,
	17 Jun 2013 17:09:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4BEC5232-D796-11E2-9303-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228118>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 13-06-17 01:52 PM, Matthieu Moy wrote:
>> The behavior of "git push --force" is rather clear when it updates only
>> one remote ref, but running it when pushing several branches can really
>> be dangerous. Warn the users a bit more and give them the alternative to
>> push only one branch.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>   Documentation/git-push.txt | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index 938d1ee..9b9e7d1 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -136,6 +136,14 @@ already exists on the remote side.
>>   	not an ancestor of the local ref used to overwrite it.
>>   	This flag disables the check.  This can cause the
>>   	remote repository to lose commits; use it with care.
>> +	Note that `--force` applies to all the refs that are pushed,
>> +	hence using it with `push.default` set to `matching` or with
>> +	multiple push destination configured may override refs other
>
> s/destination/destinations/

Good eyes.

After I re-read the one, I found that "override" somewhat a strange
expression.  There is nothing that overrides or to be overriden.

How about putting it like this?

 Documentation/git-push.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 8b637d3..21294aa 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -124,6 +124,15 @@ no `push.default` configuration variable is set.
 	not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
+	Note that `--force` applies to all the refs that are pushed,
+	hence using it with `push.default` set to `matching` or with
+	multiple push destinations configured with `remote.*.push`
+	may push out refs other than the current branch (including
+	local refs that are strictly behind their remote counterpart).
+	To force a push to only one branch, use a `+` in front of the
+	refspec to push	(e.g `git push origin +master` to force a push
+	to the `master`	branch). See the `<refspec>...` section above
+	for details.
 
 --repo=<repository>::
 	This option is only relevant if no <repository> argument is
