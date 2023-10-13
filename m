Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C3110D
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 04:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="B1uSnBSA"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BF5BE
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 21:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697172185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fp03RSeJj/8sYW2XAtyLJL7dElSw8ZqgL4DZ31Q/+Dk=;
	b=B1uSnBSAwgVPZjEYOy7KU/FJnRze3HcgDXAwgyjjEzny+SbPemWtSOn0MNFEclOivaoqYG
	UmbIm9aTEDVb5es4ahcbrTme2iL3bf2C0xcQ4RA+G9lUQD5bWCJ4Omf85Pk9qXXWr5f744
	zmy+1rHsVCrd6kaPIIc/OX6t1lhmqST+maUc3JBqjuROBR+GyKVmmMbUmBzmEW9IgzXAGU
	Nhj2cW9s9WThDheI0lSowclYa4aw8PhsGtaWEIP7VBrAC6tgWFqpxYwbQaJMr0pt+ZFPLQ
	VrjcWWdkR/3jK+nXx7V6ztNKEVhDz4GYzYXxk3hms7MCpY9ADp2qYn0sVCbdUA==
Date: Fri, 13 Oct 2023 06:43:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <ec91ff19cca3d881d4746208744663c650ebd250.camel@scientia.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
 <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
 <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
 <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
 <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
 <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
 <8f3bec2752f4c2d3ebdd29d20910a4a94f75f608.camel@scientia.org>
 <23cc509bfb433e19c7683c97314e4ac8@manjaro.org>
 <2f3ef5568ed19ac5bdcd23f84ddfb13dc6901043.camel@scientia.org>
 <161b9584c6c9a004c01bda98cea4f1f8@manjaro.org>
 <e1e187ca3d970c18e1a11d51ff93b6cb212bcbaa.camel@scientia.org>
 <31b6f4a2b88cc3a2cfa908f82f4f2302@manjaro.org>
 <c6cd3133573d5ade6d02b5da1051853a4b3885e1.camel@scientia.org>
 <60f1922b12a6ef304ffa36c334348e34@manjaro.org>
 <ec91ff19cca3d881d4746208744663c650ebd250.camel@scientia.org>
Message-ID: <6d673c1bdae41236e95e3a9fca853731@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-13 01:06, Christoph Anton Mitterer wrote:
> On Fri, 2023-10-13 at 00:36 +0200, Dragan Simic wrote:
>> It seems that "--redraw-on-quit" is a possible candidate for
>> replacing "-X" in the set of default options for less(1)
> 
> *If* some changes were made to how git handles this, it might perhaps
> be worth to consider not to touch LESS at all, but only add the
> required settings via command line arguments (i.e. -F -R ...).

Actually, that would be wrong.  If someone sets $LESS or $PAGER (or 
$GIT_PAGER, more specifically), it's up to the utility that invokes the 
pager internally not to override the user preferences configured through 
these environment variables.  That's how everyone can customize the 
pager behavior.

> Or perhaps only remove options from it, if they're known to break the
> behaviour with git (like -+R might).

Again, not the way the whole thing with pagination works.  If someone 
sets their environment variables wrong, it's simply the way they want 
it, and it isn't anyone else's business to attempt fixing it 
automatically.

> I always feel configuration via env vars is a bit fragile:
> - especially when one has generic names like POSIXLY_CORRECT there's
>   some chance that by exporting it to one program, where one wants the
>   effect, another program started off by that also gets it
>   unintentionally
> - generic terms may be used by multiple programs, causing problems

Well, fragile or not, that's the way it works.  It has its downsides for 
sure, but it's all about having each utility handle the environment 
carefully and document it in its man page(s), so the users can also 
carefully craft the values of their customized environment variables.

> Also, if one can set only one LESS var in the environment, not one for
> less "alone", one for less with git, etc. - that is unless for programs
> like bat/delta which have specific own env vars to set the pager.

$LESS can be seen as a global set of the common options for less(1), 
which may include the coloring configuration or the enablement of 
case-insensitive search, for example, while $MANPAGER, $GIT_PAGER and 
$BAT_PAGER may contain utility-specific options for less(1).  That's 
actually very good, because it makes possible to avoid duplication of 
the common options.

> So if I set e.g. LESS to something, than typically only to stuff from
> which I believe it works as expected for any possible users.
> E.g. -F might be such a case.

It's up to everyone to decide what are the common options for less(1) 
that they want to set in $LESS.

> But if I do that, git won't touch LESS and set the required -R, so I
> have to do that manually for git, e.g. either via git_config or by
> defining an alias git='LESS=FRX git'.

You don't have to define an alias, there's $GIT_PAGER for that purpose, 
as I already explained above.

Moreover, the whole idea of the various utilities touching the $LESS 
variable internally is to provide sane defaults to the users that don't 
configure $LESS, $PAGER, etc. on their own.  Once the user starts to 
provide their own environment variable(s), it's no longer up to the 
utility to help the user by altering their environment configuration.

> But in both cases it would "break" again, should ever another option be
> needed and added by git to the default LESS (which is however only set
> when it's unset).
> And in case of an alias, there would be the additional problem, that
> it's typically not picked up in non-interactive shells.

As you can see in my replies, it isn't about taking care of the users 
who provide their own environment configuration.  It's all about 
providing the set of sane defaults, for the users with no custom 
configuration.

> Long story short, it might make sense for git, to (mostly) ignore LESS
> and rather invoke less with -F -R.

No, that would be wrong on multiple levels, as I already explained in 
detail.

> The problem with that in turn would of course be that it doesn't
> automatically propagate down, if e.g. git's pager is set to detla and
> delta in turn runs less.
> However, that's IMO litte concern, since then it's delta's duty to set
> -R (if it think it needs to do so), which it actually does.

I don't know what delta is and how it actually paginates its outputs, 
but it should follow the rules of the environment-based pager 
configuration that I described in detail above.
