From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH RESEND] git submodule add: make the <path> parameter optional
Date: Sun, 04 Oct 2009 19:51:36 +0200
Message-ID: <4AC8E0A8.4000901@web.de>
References: <4AB8E8D4.40105@web.de> <7vbpl2srw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:19:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuVI2-0005Up-CT
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 19:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbZJDRwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 13:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487AbZJDRwP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 13:52:15 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:52536 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbZJDRwO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 13:52:14 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 88C58124D6756;
	Sun,  4 Oct 2009 19:51:37 +0200 (CEST)
Received: from [80.128.94.206] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MuVFA-0002T0-00; Sun, 04 Oct 2009 19:51:36 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <7vbpl2srw9.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+XwLtsuog8R8p0rquBhqo8iFGTXxTxIMFvcTdC
	7mFD+kqOSRz7DJSngEohJDuqea3c67wdCPAdrQ3A4rPmgAoeSK
	/GYur6o/wz659t7zJ83A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129512>

Junio C Hamano schrieb:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> When <path> is not given, use the "humanish" part of the source repository
>> instead.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>
>> With this patch, git submodule add behaves like git clone in this respect.
>>
>> Didn't get a response the last weeks, so here is a resend.
>>
>>
>>  Documentation/git-submodule.txt |    8 ++++++--
>>  git-submodule.sh                |    7 ++++++-
>>  t/t7400-submodule-basic.sh      |   16 ++++++++++++++++
>>  3 files changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index 5ccdd18..4ef70c4 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -10,7 +10,7 @@ SYNOPSIS
>>  --------
>>  [verse]
>>  'git submodule' [--quiet] add [-b branch]
>> -	      [--reference <repository>] [--] <repository> <path>
>> +	      [--reference <repository>] [--] <repository> [<path>]
>>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
>>  'git submodule' [--quiet] init [--] [<path>...]
>>  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
>> @@ -69,7 +69,11 @@ add::
>>  	to the changeset to be committed next to the current
>>  	project: the current project is termed the "superproject".
>>  +
>> -This requires two arguments: <repository> and <path>.
>> +This requires at least one argument: <repository>. The optional
>> +argument <path> is the relative location for the cloned submodule
>> +to exist in the superproject. If <path> is not given, the
>> +"humanish" part of the source repository is used ("repo" for
>> +"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
> 
> I do not know if this is useful in practice nor even desired.  Comments?

As nobody commented until now, i'll explain my motivation for this patch.

When adding submodules i was surprised to find that i had to explicitly
provide the pathname even though it could be easily generated from the
reponame as git clone does it. And i see git clone and git submodule add
as related commands from a users perspective, they both connect a remote
repo to a working directory.

IMHO this patch makes the ui more consistent and doesn't break existing
setups or scripts. And it is really useful because i don't do typos in
the pathname anymore ;-)

Jens
