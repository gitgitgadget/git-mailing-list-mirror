From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 5/6] fetch/pull: Don't recurse into a submodule when commits
 are already present
Date: Thu, 24 Feb 2011 00:50:18 +0100
Message-ID: <4D659D3A.2020704@web.de>
References: <4D656F25.5090007@web.de> <4D656FC7.2060201@web.de> <7vaahm5oby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsOTS-0008Kl-Ce
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab1BWXuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:50:20 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:43145 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1BWXuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:50:20 -0500
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id C77BA18935A45;
	Thu, 24 Feb 2011 00:50:18 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsOTK-0002rv-00; Thu, 24 Feb 2011 00:50:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vaahm5oby.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19eZ7GuBRqJSJeZ/+WXRUzqsMis0S3CIvW8dq+p
	zD/fAnJuqjG00CzLcIe5Hc+cTVUpfQ+UK6BhAUPWHiSNWu8+YS
	up8ifAmecdWi9YqWOqNA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167747>

Am 24.02.2011 00:21, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> diff --git a/submodule.c b/submodule.c
>> index b477c3c..ddb0a29 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -263,6 +263,13 @@ void set_config_fetch_recurse_submodules(int value)
>>  	config_fetch_recurse_submodules = value;
>>  }
>>
>> +static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
>> +{
>> +	if (!add_submodule_odb(path))
>> +		return lookup_commit_reference(sha1) != 0;
>> +	return 0;
>> +}
> 
> Don't you need to prove the usual "reachabile from the refs" here, instead
> of just the presense of a commit object?

Looks like I would. Could you please enlighten me?
