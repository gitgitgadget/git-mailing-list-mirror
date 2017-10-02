Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC68C20281
	for <e@80x24.org>; Mon,  2 Oct 2017 14:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbdJBOA0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 10:00:26 -0400
Received: from outbound1.eu.mailhop.org ([52.28.251.132]:59668 "EHLO
        outbound1.eu.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdJBOAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 10:00:25 -0400
X-MHO-User: 02ee2777-a77a-11e7-a893-25625093991c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.3
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.3])
        by outbound1.eu.mailhop.org (Halon) with ESMTPSA
        id 02ee2777-a77a-11e7-a893-25625093991c;
        Mon, 02 Oct 2017 14:00:15 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 1BB0180053;
        Mon,  2 Oct 2017 14:00:11 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 1BB0180053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1506952811;
        bh=pC1z7vFl29iN8//pV9yTqmdz8JqQzzsroQky6Jlv5Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YgQRdr9Q3u9+hTI7OmImz6mV3f6VLyFSbIxmjbwjbUSMhRsa+ogfZGbZ2IaurJU3z
         2D1sq+nXecruPxcb4IsotgkNA15G9VFfOGPs4aWUWtdi+o4hQzjEFVFkRCDePAwV0l
         86EWYoIs8vQvE3Kkt2hzLt3z0B+sjOwRM5KJvY50NPYwxM/Uy5J5ro3L4ZGvmljWJg
         5b85NkFz7QU/QEt/sf1k8KovAYYFLnQzDvJB7jn7k3yLUmL8TORYZSyYEFv0m5DTRz
         shiA+svC61+IxELuayjCzA/RZkQhXTfXzfBLgx3Bxn47QYTntZs1diZf5CjAqqfxtH
         Lbxb41FdgV9sA==
Date:   Mon, 2 Oct 2017 14:00:11 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
Message-ID: <20171002140011.GE31762@io.lakedaemon.net>
References: <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <20170926170502.GY31762@io.lakedaemon.net>
 <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for the response.  Sorry for the delay.  Had a large deadline for
$dayjob.

On Wed, Sep 27, 2017 at 12:11:14AM +0200, Johannes Schindelin wrote:
> On Tue, 26 Sep 2017, Jason Cooper wrote:
> > On Thu, Sep 14, 2017 at 08:45:35PM +0200, Johannes Schindelin wrote:
> > > On Wed, 13 Sep 2017, Linus Torvalds wrote:
> > > > On Wed, Sep 13, 2017 at 6:43 AM, demerphq <demerphq@gmail.com> wrote:
> > > > > SHA3 however uses a completely different design where it mixes a 1088
> > > > > bit block into a 1600 bit state, for a leverage of 2:3, and the excess
> > > > > is *preserved between each block*.
> > > > 
> > > > Yes. And considering that the SHA1 attack was actually predicated on
> > > > the fact that each block was independent (no extra state between), I
> > > > do think SHA3 is a better model.
> > > > 
> > > > So I'd rather see SHA3-256 than SHA256.
> > 
> > Well, for what it's worth, we need to be aware that SHA3 is *different*.
> > In crypto, "different" = "bugs haven't been found yet".  :-P
> > 
> > And SHA2 is *known*.  So we have a pretty good handle on how it'll
> > weaken over time.
> 
> Here, you seem to agree with me.

Yep.

> > > SHA-256 got much more cryptanalysis than SHA3-256, and apart from the
> > > length-extension problem that does not affect Git's usage, there are no
> > > known weaknesses so far.
> > 
> > While I think that statement is true on it's face (particularly when
> > including post-competition analysis), I don't think it's sufficient
> > justification to chose one over the other.
> 
> And here you don't.
> 
> I find that very confusing.

What I'm saying is that there is more to selecting a hash function for
git than just the cryptographic assessment.  In fact I would argue that
the primary cryptographic concern for git is "What is the likelihood
that we'll wake up one day to full collisions with no warning?"

To that, I'd argue that SHA-256's time in the field and SHA3-256's
competition give them both passing marks in that regard.  fwiw, I'd also
put Blake and Skein in there as well.

The chance that any of those will suffer sudden, catastrophic failure is
minimal.  IOW, we'll have warnings, and time to migrate to the next
function.

None of us can predict the future, but having a significant amount of
vetting reduces the chances of catastrophic failure.

> > > It would seem that the experts I talked to were much more concerned about
> > > that amount of attention than the particulars of the algorithm. My
> > > impression was that the new features of SHA3 were less studied than the
> > > well-known features of SHA2, and that the new-ness of SHA3 is not
> > > necessarily a good thing.
> > 
> > The only thing I really object to here is the abstract "experts".  We're
> > talking about cryptography and integrity here.  It's no longer
> > sufficient to cite anonymous experts.  Either they can put their
> > thoughts, opinions and analysis on record here, or it shouldn't be
> > considered.  Sorry.
> 
> Sorry, you are asking cryptography experts to spend their time on the Git
> mailing list. I tried to get them to speak out on the Git mailing list.
> They respectfully declined.

Ok, fair enough.  Just please understand that it's difficult to place
much weight on statements that we can't discuss with the person who made
them.

> > However, whether we chose SHA2 or SHA3 doesn't matter.
> 
> To you, it does not matter.

Well, I'd say it does not matter for *most* users.

> To me, it matters. To the several thousand developers working on Windows,
> probably the largest Git repository in active use, it matters. It matters
> because the speed difference that has little impact on you has a lot more
> impact on us.

Ahhh, so if I understand you correctly, you'd prefer SHA-256 over
SHA3-256 because it's more performant for your usecase?  Well, that's a
completely different animal that cryptographic suitability.

Have you been able to crunch numbers yet?  Will you be able to share
some empirical data?  I'd love to see some comparisons between SHA1,
SHA-256, SHA512-256, and SHA3-256 for different git operations under
your work load.

> > If SHA3 is chosen as the successor, it's going to get a *lot* more
> > adoption, and thus, a lot more analysis.  If cracks start to show, the
> > hard work of making git flexible is already done.  We can migrate to
> > SHA4/5/whatever in an orderly fashion with far less effort than the
> > transition away from SHA1.
> 
> Sure. And if XYZ789 is chosen, it's going to get a *lot* more adoption,
> too.
> 
> We think.
> 
> Let's be realistic. Git is pretty important to us, but it is not important
> enough to sway, say, Intel into announcing hardware support for SHA3.
> And if you try to force through *any* hash function only so that it gets
> more adoption and hence more support,

That's quite a jump from what I was saying.  I would never advise using
code in a production setting just to increase adoption.

What I /was/ saying: Let's say you don't get what you want, and SHA3-256
is chosen.  It's not the end of the world from a cryptographic PoV.
The hard work of making the git (and libgit2) codebases hash-flexible is
already done.  So, if you're correct, and SHA3 was too immature, the
increased visibility will help us discover that more quickly.  And, the
code will already be in a position to conduct an orderly migration.

Will it still be costly?  Yes.  But I would argue that it's naive to
think that we will be using git/sha3-256 or git/sha-256 10 to 15 years
from now.  It might be git, it might not.  But there *will* be another
migration of existing data (code, history, etc) from one object storage
model to another.  It might be git/SHA4-512, or hg/sha4-384.

So, we aren't trying to find the perfect hash function so that we
naively think we'll never have to change again.  Rather, we're choosing
the next hash function so that we can hold off another migration for as
long as possible.  After all, SHA4-512 doesn't exist yet. ;-)

> in the short run you will make life
> harder for developers on more obscure platforms, who may not easily get
> high-quality, high-speed implementations of anything but the very
> mainstream (which is, let's face it, MD5, SHA-1 and SHA-256). I know I
> would have cursed you for such a decision back when I had to work on AIX
> and IRIX.

I think you're assuming that all developers on obscure platforms have
a similar git usecase to your current one.  I've not heard of that being
the case.

> > For my use cases, as a user of git, I have a plan to maintain provable
> > integrity of existing objects stored in git under sha1 while migrating
> > away from sha1.  The same plan works for migrating away from SHA2 or
> > SHA3 when the time comes.
> 
> Please do not make the mistake of taking your use case to be a template
> for everybody's use case.

I wasn't.  But I will argue that my usecase is valid.  Just as yours is.

> Migrating a large team away from any hash function to another one *will*
> be painful, and costly.

Assuming that it will never happen again would make that doubly costly.

> Migrating will be very costly for hosting companies like GitHub, Microsoft
> and BitBucket, too.

<with_my_business_hat_on>
GitHub and BitBucket have git as the core of their business model.  If
they aren't keeping an eye on the future path of git and maintaining
migration plans, shame on them.
</with_my_business_hat_on>

Thanks,

Jason.
