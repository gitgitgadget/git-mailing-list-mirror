From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Mon, 14 Jan 2008 23:55:47 -0500
Message-ID: <478C3CD3.6010504@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>	<478855B5.9070600@gmail.com>	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>	<47885B2C.8020809@gmail.com>	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>	<4788BFA8.2030508@gmail.com>	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>	<47891658.3090604@gmail.com>	<alpine.LSU.1.00.0801122123430.8333@wbgn129.biozentrum.uni-wuerzburg.de>	<47893F53.2070908@gmail.com>	<alpine.LSU.1.00.0801132220200.8333@wbgn129.biozentrum.uni-wuerzburg.de>	<478AD5A0.50900@gmail.com> <7vabn9m30a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 05:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEdqf-0006qK-E4
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 05:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbYAOEz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 23:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbYAOEz4
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 23:55:56 -0500
Received: from hs-out-0708.google.com ([64.233.178.240]:23201 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751766AbYAOEzz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 23:55:55 -0500
Received: by hs-out-2122.google.com with SMTP id 54so2164767hsz.5
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 20:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=afC2nw3dAm7J9ZHSP8VvwGNg8rOak70lWme4v96GinM=;
        b=Q3B6veTTlIqU3oYCAHbatFM52aEhLRC4uQmLfNadgSzD6/V1ecf47rOClCpLHLU+k147WCZHtR1K/paLgouujCqoPfq4Ud9QtkNaEeiYiLaDXhFhhoSNmfssR6otOtKkqL4IewREa6BtlgDhRHgPhVtZxa1Jr2CbWJGUbTplqyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DT5/MWU3cHllMn4oaD55ekGj6ONT8pO9fejNxcRVxLPqXABNE4fjEZSaf4jZ57a6TaVc3OSbP9HE614db15VXkwX88iwagSyvWkAfhoGj6OZ+LNoqfnKTsZKvwflmZJeWReZF+Q+rOXDF5BKMpkW9zm+ODra6FPyPfJdyBb78v0=
Received: by 10.150.140.6 with SMTP id n6mr2799029ybd.33.1200372952248;
        Mon, 14 Jan 2008 20:55:52 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id 39sm386910wrl.32.2008.01.14.20.55.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 20:55:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vabn9m30a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70499>

Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>   
>> ... if what
>> we need to fetch from is in fact not origin (even though the master
>> project knows what server to access), submodule update in fact doesn't
>> even work ...
>>     
>
> This is an interesting point.
>
> Perhaps git-submodule.sh::modules_update should use $url it
> obtains from the configuration in the upper level when running
> git-fetch in the submodule.
>   
yes, I like this change, it works very nicely. but that last patch is 
only a partial solution...
> If you view the problem this way, your earlier "git fetch while
> the HEAD is detached always uses 'origin'" may turn out to be a
> non-issue.
>
> Which again brings us back to Johannes's earlier point.  If the
> issue is about submodule, maybe what needs to be fixes is in
> git-submodule, and not the defaulting to 'origin' git-fetch and
> friends do.
>   
Nope, git submodule *still* requires origin (e.g., execute git submodule 
init or update on a detached head). We are dancing around the issue, not 
fixing the root cause. This is perhaps illuminated by splitting projects 
into two camps:

Camp1 - there is no need to distinguish the upstream servers (or there 
is only one), calling it/all origin is fine.
Camp2 - there is a need to distinguish servers, they are not identical, 
uniform naming across project is required (but folks might still like to 
be able to have a default, and probably want to change that default on 
occasion), .

So far, git is written as if the whole world is in Camp1, and the 
problems appear for Camp2. The underlying issue is that git has 
convolved the referencing, naming, and designation of a default remote 
into *one* thing when it is really three things. For git, the default 
remote is named origin, which is also how it is designated as the 
default, and is also how you reference the default in commands. 
Non-default remotes have an arbitrary nickname, are not default as they 
are not called origin, and are referenced by using their nicknames.

To serve Camp2 (and not impact Camp1), origin should be a handle that 
dereferences to the name of the default remote, and designation of the 
default remote should be by a separate config item rather than a special 
name for the remote. Assume core.origin names the default remote:

For Campl, we have
    core.origin=origin
with the default remote having nickname origin.

For Camp2, we could have
    core.origin=<whatever>
with the default remote having nickname <whatever>

At the command line, "git fetch" dereferences to $(git config 
core.origin), which is origin for Camp1, but <whatever> for Camp2. So, 
Camp1 users don't notice anything is different, and Camp2 users don't 
have a number of different servers all referred to as "origin".

The key is that in Camp2, a given remote now can have  the *same* 
nickname for all members of the project, regardless of which remote they 
have made their default. "git fetch" and "git fetch origin" still work, 
they just dereference core.origin (perhaps verbosely to warn that the 
remote being updated is *not* actually named origin), then update the 
remotes/$(git config core.origin)/* branches.

Obviously, Camp1 with core.origin=origin is the default, and everything 
in user land works exactly as it does today. Camp2 with 
core.origin~=default is only mentioned in the graduate level git course 
and shielded with "Caution, Sharp Knives!" signs. Fine, I need the knives.

Mark
