Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90F41F406
	for <e@80x24.org>; Fri, 11 May 2018 19:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeEKTZm convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 11 May 2018 15:25:42 -0400
Received: from elephants.elehost.com ([216.66.27.132]:13897 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeEKTZm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 15:25:42 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w4BJPcvF091308
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 11 May 2018 15:25:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Bryan Turner'" <bturner@atlassian.com>,
        "'Git Users'" <git@vger.kernel.org>
References: <004d01d3e7e2$517f78d0$f47e6a70$@nexbridge.com>     <CAGyf7-GJgpCZ=wEorLxYOm_ABaDamWKkTnOtaAwti35DJ_zS7g@mail.gmail.com>    <001401d3e899$60cf3930$226dab90$@nexbridge.com> <xmqq7eobhqpi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7eobhqpi.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Best Practices Request] clean/smudge configuration
Date:   Fri, 11 May 2018 15:25:32 -0400
Message-ID: <001601d3e95d$d76272a0$862757e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFnnQJFkppPCcoZJFTxZlMkMoJajAGXzmEUAnaICtMBhGksnKTW6XhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On May 10, 2018 10:27 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > What if we create a ../.gitconfig like ../.gitattributes, that is
> > loaded before .git/config?
> 
> You should not forget one of the two reasons why clean/smudge/diff etc.
> drivers must be given with a step of redirection, split between attributes and
> config.  "This path holds text from ancient macs" at the logical level may be
> expressed in .gitattributes, and then "when checking out text from ancient
> macs, process the blob data with this program to turn it into a form suitable
> for working tree" is given as a smudge filter program, that is (1) suitable for
> the platform _you_ as the writer of the config file is using *AND* (2)
> something you are confortable running on behalf of you.
> 
> We *deliberately* lack a mechanism to pay attention to in-tree config that
> gets propagated to those who get them via "git clone", exactly because
> otherwise your upstream may not just specify a "smudge" program that your
> platform would be unable to run, but can specify a "smudge" program that
> pretends to be a smudger, but is actually a program that installs a keylogger
> and posts your login password and bank details to this mailing list ;-)
> 
> So, no, I do not think in-tree configuration will fly.

I agree, which is why I asked the original question instead of posting it as a formal patch. We would probably get a brand new CVE implementing the proposed proto-changes even if the original intent was internal trusted repositories only. That's why I asked this as a "Best Practices" type question, which I think I have a better idea on now. The actual situation is rather cool from a DevOps point of view, and whatever the ultimate solution is, might make for a nice presentation at some future conference 😉.

Cheers and thanks,
Randall

