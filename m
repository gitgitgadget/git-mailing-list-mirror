From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expand ~ and ~user in core.excludesfile, commit.template
Date: Mon, 16 Nov 2009 22:22:21 -0800
Message-ID: <7viqd9isbm.fsf@alter.siamese.dyndns.org>
References: <1258366060-27966-1-git-send-email-Matthieu.Moy@imag.fr>
 <m3k4xqc9qj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Karl Chen <quarl@quarl.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 07:22:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHSX-0005IJ-Bh
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbZKQGW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbZKQGW0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:22:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbZKQGWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:22:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F1D480EDD;
	Tue, 17 Nov 2009 01:22:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zmTtZW5kG+C2c39yo421s8ReTLA=; b=nXUmwy6VWnpd/2nSNnWh0kk
	jhyfdjn1CWh+X7M9vtmIHatwoh6i/ah2i5n0F0hix3JBHDRP/2N6/Kvk0OpDSiAl
	fVvFdCcxnqTsahuDF45x99Wz4BZyLicSpNnCav8dIEq8dwZKAxYcsKDoSB8KYmbO
	fjUu7O7UXZgNetsQ50nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=G2bSNlLd8qQSUE2VQ7ZWULwHAqDspfQEBaJq1Nb8b/2kGoiPR
	CgVTnhE4cRzVi/7G5xmjdlKZ0k0+SiRQpSzawj+bWDugPR6ppgBgBVJ4R27Li0in
	jX19mS5KSMer1JwE6U5xBM6SupsYF92A3cbeMIy2cnDEqjjbkzzdNKFyg0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C771980EDC;
	Tue, 17 Nov 2009 01:22:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E195F80EDB; Tue, 17 Nov
 2009 01:22:22 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 940C4CAA-D341-11DE-A3EA-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133062>

Jakub Narebski <jnareb@gmail.com> writes:

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index d1e2120..c37b51d 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -380,7 +380,8 @@ Common unit suffixes of 'k', 'm', or 'g' are supported.
>>  core.excludesfile::
>>  	In addition to '.gitignore' (per-directory) and
>>  	'.git/info/exclude', git looks into this file for patterns
>> -	of files which are not meant to be tracked.  See
>> +	of files which are not meant to be tracked.  "~" and "~user"
>> +	are expanded to the user's home directory.  See
>>  	linkgit:gitignore[5].
>>  
>>  core.editor::
>
> It would be nice to have an option to git-config which would do such
> expansion, as a separate type similar to --int and --bool, e.g.:
>
>   git config --path section.key
>
> so that not only core.excludesfile could use this new feature, but for
> example also core.worktree, commit.template, gitcvs.logfile,
> mailmap.file, and perhaps also *.receivepack and *.uploadpack

What should "git config -l" do for these (and core.excludesfile)?
