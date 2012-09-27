From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: introduce GIT_GLOBAL_CONFIG to override
 ~/.gitconfig
Date: Thu, 27 Sep 2012 10:50:34 -0700
Message-ID: <7vk3vfqrrp.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
 <1348757171-3223-1-git-send-email-artagnon@gmail.com>
 <vpq626zjtds.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>,
	Anurag Priyam <anurag08priyam@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THIEa-00038w-Pv
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab2I0Rui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:50:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330Ab2I0Rug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:50:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AAD99EF3;
	Thu, 27 Sep 2012 13:50:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jtvVQ5OQIl9AVzM11zypJkxj2zQ=; b=J5L28+
	Tm7H6iDdBBxsX3J57BXXjNQqPjT18+3Vp04QPVbu2tyrOeeSEM+3ZFYk/K4HdCg2
	sRqoWOAyLNK811w8jGgvxc45oziEakN+QXn4ULRDxYH8KC8nO+Ua77+dI/yXzVXr
	TvbWU9mnidBs3/416JuyljuHbxhh0Y8SxmxHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RRTizXuggBfmrcV/bMWD8yJwcQ+l0CtG
	gwUF1gwUmKA72pB4om9OsptLDmnaLAbEM3bMY957EQ0o6GKPkX+Pw4Xy5uKKkLQ9
	HJBWn6cDngOrn8ju+NK83BDtSuAVizJKqpqR2nUSEsvE7H8XyjRWtyqqX+FSCUbR
	ErO7WxKuNR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57CA89EF2;
	Thu, 27 Sep 2012 13:50:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5A239EF0; Thu, 27 Sep 2012
 13:50:35 -0400 (EDT)
In-Reply-To: <vpq626zjtds.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Thu, 27 Sep 2012 18:57:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7403294-08CB-11E2-B7C8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206499>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index eaea079..c8db03f 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -205,6 +205,9 @@ $GIT_DIR/config::
>>  	User-specific configuration file. Also called "global"
>>  	configuration file.
>>  
>> +$GIT_GLOBAL_CONFIG::
>> +	Overrides the path of the global configuration file.
>> +
>
> I'm not particularly in favor of introducing another environment
> variable, but if you are to introduce it, why just override the
> configuration file, and not $HOME completely (e.g. to override
> $HOME/.git-credentials too).
>
> There was a patch proposing that here ($GIT_HOME to override $HOME):

I think both of these are at the entrance of slippery slope to
insanity I'd rather not to venture into.

If somebody hates ~/.dotmanyfiles so much, why not do HOME=~/dots/,
instead of having to set GIT_HOME to move ~/.gitconfig, FROTZ_HOME
to move ~/.frotzconfig, MAIL_HOME to move ~/.mailrc, etc.?

I wouldn't be surprised if some _other_ things break with your HOME
pointing at a directory inside your home directory, but then it may
be better to fix that other thing instead.
