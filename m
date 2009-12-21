From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Introduce the GIT_HOME environment variable
Date: Mon, 21 Dec 2009 17:54:03 +0100
Message-ID: <4B2FA82B.3080305@drmicha.warpmail.net>
References: <4B2C0828.4010505@signalbeam.net>	<20091219013246.GD25474@genesis.frugalware.org>	<7vhbrnodd9.fsf@alter.siamese.dyndns.org>	<4B2C5A1A.8000201@signalbeam.net>	<7vzl5fik3o.fsf@alter.siamese.dyndns.org>	<20091219153046.GG25474@genesis.frugalware.org>	<vpqeimq51pq.fsf@bauges.imag.fr>	<7vskb6bwvu.fsf@alter.siamese.dyndns.org>	<vpqhbrkd3o6.fsf@bauges.imag.fr>	<20091221155902.GA22665@sigill.intra.peff.net> <vpqskb49tuq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Moe <moe@signalbeam.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 21 17:55:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMlXp-0000kw-3Z
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 17:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbZLUQzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 11:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZLUQzg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 11:55:36 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58177 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155AbZLUQzg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2009 11:55:36 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E2F05C79C7;
	Mon, 21 Dec 2009 11:55:34 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 21 Dec 2009 11:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Fu/BuY4L2+rCqxffmWC1sUjNl0E=; b=QIGBpiGdBC9teClWDitV8k2Ahtk3TC+aCleLc+aIVoS+dGlsKrjpKrUdkdgKsBMU03Y9AXsuoriItZNd2h2oVhQWavMGfvqLGoWHLm6LCUHtIHUJGAyop+j3Hwwf72BziWwL8M6HDrwxT9cg3JqWgsRUORN/nMnp1tUvyh2SvjQ=
X-Sasl-enc: 8XgmWqOjk3d9YMV1d9qGCEWiAUA25gbcDO9nIOv073Nq 1261414534
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 953E24B5935;
	Mon, 21 Dec 2009 11:55:33 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <vpqskb49tuq.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135560>

Matthieu Moy venit, vidit, dixit 21.12.2009 17:26:
> Jeff King <peff@peff.net> writes:
> 
>> Are we even close to having this sort of universal support for
>> ~/.config?
> 
> Definitely not universal as of now. Probably precisely because each
> application thinks "I'll take care of $XDG_CONFIG_HOME after others
> do" ;-).
> 
>> Traditionally, the standard for Unix
>> has been for config files to be $HOME/.something. You can argue that
>> ~/.config is a better standard, but I don't think git is failing to
>> use a standard; it is simply following a different one.
> 
> I've probably been unclear about this. I'm not arguing about moving
> away from $HOME/.gitconfig as the default (IOW, we're in agreement
> here ;-) ). It's there, and the migration path would be much more
> painfull than the benefit.
> 
> What I'm saying is that _if_ we introduce a variable to point to an
> alternate .gitconfig, then we should use something like
> $XDG_CONFIG_HOME/git/config and not $GIT_HOME/.gitconfig
> 
> I don't have a strong opinion on whether we should introduce such
> variable (it seems the only use-case is the one which started this
> thread, and it is already solved without it, so ...).
> 
>> But we do have such a variable: $HOME. The concept of $GIT_HOME was
>> proposed to provide a way to divert _just_ git to a different config
>> directory, something that would not be any easier with
>> $XDG_CONFIG_HOME.
> 
> Right, but I don't see any use-case for this.
> 
> The use-case which started this thread was to have several physical
> users using the same Unix account, with the desire that each physical
> user should be able to use his own editor setups. In this case, you
> want your editor and your other applications to follow the schema.
> 
>> Anyway, as far as the future of git goes, even if we did want to switch
>> to $XDG_CONFIG_HOME, we could not do so suddenly without breaking
>> everybody's current setup. Which would mean any implementation of it
>> would have to handle both the current and the new proposed locations.
>> You can obviously just read from both, but there are a lot of open
>> questions, like "which should take precedence?" and "what does git
>> config --global --edit do?". I am not opposed to hearing a clever
>> proposal that handles all such issues, but I am not going to think too
>> hard about it myself. :)
> 
> Right, the thing I had in mind was to use $XDG_CONFIG_HOME just like
> $GIT_HOME (i.e. use it if it's set), but doing so would suddenly break
> the setup of people having already set $XDG_CONFIG_HOME, and having a
> $HOME/.gitconfig.
> 
> Well, then, I don't know, maybe my proposal wasn't as clever as I
> thought ;-).

Well, I'd say the usual approach would be "use the first one found out
of $XYZ/config and $HOME/.gitconfig in this order", whether XYZ equals
$GIT_HOME or $XDG_CONFIG_HOME/git or what not. And that applies both to
reading as well writing the config. We should only merge config from
different types of sources (system/global/local), not from alternate
locations within the same type.

That way, nobody's setup gets broken, and having "git_custom_home()"
factorized out there is no real maintenance burden. I have no opinion
about the choice of XYZ.

Michael
