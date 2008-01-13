From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sun, 13 Jan 2008 10:47:16 -0500
Message-ID: <478A3284.1000102@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>	<478855B5.9070600@gmail.com>	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>	<47885B2C.8020809@gmail.com>	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>	<4788BFA8.2030508@gmail.com>	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>	<47891658.3090604@gmail.com>	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>	<47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 16:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE53v-0006VI-7k
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 16:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYAMPrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 10:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbYAMPrV
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 10:47:21 -0500
Received: from ro-out-1112.google.com ([72.14.202.181]:15938 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYAMPrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 10:47:21 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2134614roc.5
        for <git@vger.kernel.org>; Sun, 13 Jan 2008 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=4Iiuv34Npgf3AR0Lm8VdcoGRU+J3Hs0IWzmeF8o1T7k=;
        b=bGBiv2xr5h5tWuJ+UQyrz9+cjSzL1WJQ9EjVZPlhn+zQDQo4dEyv7+lDuL77QCS5k5S4aOVMMTskxzYDLCoJ57mb5OvMCyQgBdzQD7Bf4hAMUL887LTIGbYBP5hoz7GE9Su44BEI6muyPP6ZxAN4exazwHNs/s7ZD6FbWS33PL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Fz+HvgUmo6oMrLGfRuQ3uwKkE0wQ44l0Z/3J3EohMfxXmiiDb7xtteIxYG1aJnf2LDm8RdxOj/DsSmkKzl7FzoZdz0yfyZcq94XIZix+fFPT+X5YlUsF/nkswNyj1k+LJCtNK9ktmeFfBhydOJSIQobU8zhtTmisx3wqAxiQPw8=
Received: by 10.114.78.1 with SMTP id a1mr2639405wab.14.1200239239201;
        Sun, 13 Jan 2008 07:47:19 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id h37sm19011901wxd.6.2008.01.13.07.47.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jan 2008 07:47:17 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70389>

Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>   
>> Basically, I think an important (but not complete) test of the design
>> is that
>>
>>    git clone -o frotz git://frotz.foo.bar/myproject.git
>>    cd myproject
>>    git submodule init
>>    git submodule update
>>
>> work, with origin = frotz throughout the submodules, and with the
>> whole project correctly checked out even if the entire project was
>> rehosted onto a different server.
>>     
>
> I like that.  This is a very good argument, especially because
> it clarifies very well that the issue is not about "'submodule
> init' misbehaves" but "fetch/pull/merge does not play well with
> clone -o"
Carrying the above forward...  Assume I have a checked out project as 
above, then in top-level master project I do:

git remote add zoo git://zoo.tar.fu hisfork.git
git fetch zoo
git checkout --track -b fork zoo/fork
git submodule update

I claim the submodule machinery *should* now follow master's default 
remote, which is "zoo", for the current branch. In addition, the 
submodule machinery should define remote "zoo" in each submodule  where 
it does not already exist, using the same logic using in the original 
init/update phase. This should only apply to modules defined using 
relative urls.

Basically, this formalizes the notion that:

* submodules defined using relative urls are "owned" by the master 
project and will exist anywhere the master does.
* submodules defined using absolute urls are incorporated into the 
project but are separately managed. (While some improved mechanism to 
automate their management from top-level may be proposed, it is not 
obvious to me nor addressed here.)

The subsequent patch modifies git-submodule to implement this logic, and 
applies on top of my previous series.

(Note: I cannot find my latest series in the git-archives on gmane nor 
on marc.info, both have only part, and I am suspicious that something 
went wrong in my sending via gmail, so I am resending the series here, 
now five patches long. Please excuse if this is redundant).

Mark
