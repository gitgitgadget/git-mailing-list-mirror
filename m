Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9381F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbeFTVQx (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:16:53 -0400
Received: from ao2.it ([92.243.12.208]:50828 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933146AbeFTVQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:16:52 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fVkSg-0007mT-MJ; Wed, 20 Jun 2018 23:16:18 +0200
Date:   Wed, 20 Jun 2018 23:16:50 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH 03/10] t7411: be nicer to other tests and really
 clean things up
Message-Id: <20180620231650.c53bbbd1cd9cc391a6ed60fa@ao2.it>
In-Reply-To: <CAGZ79kYJUrT8kZWWKVbJXdtHA_3gHtseS3zMhWZwYF3=3bf4_Q@mail.gmail.com>
References: <20180514105823.8378-1-ao2@ao2.it>
        <20180514105823.8378-4-ao2@ao2.it>
        <CAGZ79kYJUrT8kZWWKVbJXdtHA_3gHtseS3zMhWZwYF3=3bf4_Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 14 May 2018 18:23:22 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> > Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
> > invalid lines in .gitmodules but then only the second commit is removed.
> >
> > This may affect subsequent tests if they assume that the .gitmodules
> > file has no errors.
> >
> > Since those commits are not needed anymore remove both of them.
> >
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> >
> > I am putting these fixups to the test-suite before the patch that actually
> > needs them so that the test-suite passes after each commit.
> >
> >  t/t7411-submodule-config.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> > index 0bde5850a..a648de6a9 100755
> > --- a/t/t7411-submodule-config.sh
> > +++ b/t/t7411-submodule-config.sh
> > @@ -135,7 +135,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
> >                         HEAD submodule \
> >                                 >actual &&
> >                 test_cmp expect_error actual  &&
> > -               git reset --hard HEAD^
> > +               git reset --hard HEAD~2
> >         )
> >  '
> 
> As this is the last test in this file, we do not change any subsequent
> tests in a subtle way.
> Good!
> 
> This is
> Reviewed-by: Stefan Beller <sbeller@google.com>
> 
> FYI:
> This test -- of course -- doesn't quite follow the latest coding guidelines,
> as usually we'd prefer a test_when_finished "<cmd to restore>"
> at the beginning of a test.

I'll keep that in mind for new tests, trying to remember that
'test_when_finished' does not work in a subshell.

BTW I can use 'test_when_finished' here as well, maybe adding a comment
to clarify the the command also cleans up something from a previous
test.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
