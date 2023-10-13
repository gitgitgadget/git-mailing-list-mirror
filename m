Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9615ACB
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WEH7IMIT"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B828BB
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697209244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMV1Y3sgVd1wiFQJixLw37eX489ynR9B0Ayf9kiRCMU=;
	b=WEH7IMITfDY4VeTxJ8RgBBfLWpPiEJMslcboOI6dKqB5T0IL8Ro0/i9JCam5thhwUfqJxP
	+P8d5f+YF/pt2JQW4H2XbHlF918em520t34IivXZuh4Auh/IW8xB673DXAsD6HThlF07/w
	o0/v2LH8aKq6XkLxB1fRBDZYzTP94rDT+kFTYTBJkZKJ4zGV/r2dJVHtEALv1ZbloMAOno
	35Big0P0j7OhWXKfpvSc+4lK9UVqqEXTBPLVx4XbtSty1cXZ/6IIZmCjnOm0x9cv0XcVzO
	iDc83/leTlsZmguZFbSML2hHnpgWZ/FbpwS8SBtHiVfDDy9I4AC1XF/Int/gkg==
Date: Fri, 13 Oct 2023 17:00:44 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <48ff9c2ac262cec32ab4681e8417413488278294.camel@scientia.org>
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
 <6d673c1bdae41236e95e3a9fca853731@manjaro.org>
 <48ff9c2ac262cec32ab4681e8417413488278294.camel@scientia.org>
Message-ID: <2bbfc823d05434b63ef3e119df106d4e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-13 15:45, Christoph Anton Mitterer wrote:
> On Fri, 2023-10-13 at 06:43 +0200, Dragan Simic wrote:
>> Actually, that would be wrong.  If someone sets $LESS or $PAGER (or
>> $GIT_PAGER, more specifically), it's up to the utility that invokes
>> the pager internally not to override the user preferences configured
>> through these environment variables.  That's how everyone can 
>> customize
>> the pager behavior.
> 
> Well, but if its clear that the output would otherwise be garbage (e.g.
> because -R is missing).

Well, it's the basic principle of "garbage in, garbage out".  If there's 
something wrong with the contents of the environment variables, that's 
simply the way the user configured it, and it's only their job to get it 
right.

> In any case right now we have the situation that a user cannot just
> easily set LESS in his environment, with a minimum set of options, and
> git's use of less will continue flawlessly out of the box, as the -R
> would be missing.

Let me repeat that it isn't the job of git or any other pager-enabled 
utility to fix the user-defined environment.  Otherwise, the user 
actually wouldn't be able to make their choice freely.

>> Again, not the way the whole thing with pagination works.  If someone
>> sets their environment variables wrong, it's simply the way they want
>> it, and it isn't anyone else's business to attempt fixing it
>> automatically.
> 
> Well, I wouldn't agree with that.
> LESS foremost a env var to configure less (surprise ^^).
> 
> If git (or anyone else) uses less internally, e.g. because they don't
> want to implement their own pager, fine... but then they cannot just
> blindly assume that LESS is set only for git's (or any other tool's
> needs).

You seem to be missing the presence of other enviroment variables, 
namely $GIT_PAGER, which I already described in detail in my previous 
reply.  I'd appreciate if you'd read that description in detail, and 
possibly test it a bit.

> So I'd say the proper way is rather that any such tool makes sure, that
> any options strictly required as set no matter what. Just as e.g. delta
> does.

Again, that's simply wrong and defeats the user's freedom of choice.

>> Well, fragile or not, that's the way it works.  It has its downsides
>> for
>> sure, but it's all about having each utility handle the environment
>> carefully and document it in its man page(s), so the users can also
>> carefully craft the values of their customized environment variables.
> 
> Sure, but from a user's view, the use of less (or anything else) within
> git is conceptually completely opaque.

Actually, it isn't, because there are $LESS, $PAGER and $GIT_PAGER 
environment variables to customize the behavior.

> In less' manpage LESS isn't documented as "oh and you must make sure -R
> is included or otherwise git will break"...

Quite frankly, it would be silly to expect the less(1) man page to 
mention something about git(1).

>> $LESS can be seen as a global set of the common options for less(1),
> 
> o.O ... but, as I've described, one cannot really use it as that:
> 
> If I globally set e.g. LESS="F" because my desire is to make less
> always exit as soon as the file fits on a screen, which I think is a
> reasonable thing to do, git would no longer add "R" and output would
> break.

Again, you seem not to understand well the distinction between the 
global settings (i.e. $LESS and $PAGER) and the utility-specific 
settings (e.g. $GIT_PAGER).  Or you maybe simply refuse to understand 
it, I don't know.

>> You don't have to define an alias, there's $GIT_PAGER for that
>> purpose, as I already explained above.
> 
> Well, yes... and as I've said before, one could also solve it via
> git_config... but the problem stays the same... as soon as someone
> wants to use LESS as global less options just as you described it
> yourself, git will no longer worker properly because of the missing -R.
> 
> And actually if one would use GIT_PAGER one would again defeat the
> purpose of a allegedly global options LESS, because unless one does
> something like GIT_PAGER="${LESS}R" it wouldn't see any changes made to
> LESS.

Let me clarify that the contents of $LESS is applied by less(1) 
internally, so the final runtime configuration for less(1) is a sum of 
the configurations made available through the $LESS and $PAGER (or 
$GIT_PAGER) environment variables.  It's a rather powerful approach, if 
used properly.

>> Moreover, the whole idea of the various utilities touching the $LESS
>> variable internally is to provide sane defaults to the users that
>> don't
>> configure $LESS, $PAGER, etc. on their own.
> 
> Then I don't see what the big problem would be to just do it via a
> command argument - if someone really has ever some reasons to remove --
> RAW‐CONTROL‐CHARS from the command options when less is invoked via git
> ... then he could still go into git_config and set that manually.
> 
> But it would seem to me that the overall handling would be much more
> what one expects, than when doing the same via LESS.

Again, adding or modifying any command-line arguments by git itself 
would defeat the purpose of the environment variables and prevent the 
users from making their choice of the pagination configuration freely.

>> I don't know what delta is and how it actually paginates its outputs,
>> but it should follow the rules of the environment-based pager
>> configuration that I described in detail above.
> 
> Well, AFAIU, it doesn't and for good reasons :-)

In that case, delta does it wrong, and I hope you understand why.

> Anyway... I think all necessary things have been said and this thread
> has grown far to large with only semi-related stuff... so thanks for
> all the replies why git uses "-X".

I hope all this was useful to you.  It was useful to me. :)
