Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C571F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752408AbeCMTcj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 13 Mar 2018 15:32:39 -0400
Received: from elephants.elehost.com ([216.66.27.132]:58045 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbeCMTci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:32:38 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w2DJWVZw085736
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 13 Mar 2018 15:32:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Daniel Jacques'" <dnj@google.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>        <871sguorb5.fsf@evledraar.gmail.com>        <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>        <87y3iwp2z0.fsf@evledraar.gmail.com> <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfu533jrk.fsf@gitster-ct.c.googlers.com>
Subject: RE: Why don't we symlink libexec/git-core/* to bin/git?
Date:   Tue, 13 Mar 2018 15:32:25 -0400
Message-ID: <003d01d3bb02$076aba00$16402e00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJjm8gbyweqSxaZnaJKp1dl7V+alQIYgxv0AZAhHjYBZK0wTAGvlUekArgcwT6iYyImgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 13, 2018 2:37 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > Related to this, I came across this bug report
> > https://gitlab.com/gitlab-org/omnibus-gitlab/issues/3265 which is
> > wondering why we're installing N copies of the git binary, presumably
> > they're building with NO_INSTALL_HARDLINKS.
> > ...
> > But is there any reason anyone can think of for why we shouldn't be
> > figuring out the relative path and symlinking the two?
> 
> 
> There is no fundamental reason not to offer such an "install" method as an
> option; unless you count a more philosophical aversion to use symlinks due
> to (perceived) additional fragility, that is.
> 
> The resulting code may become messier than without, but as long as it is
> without the reasonable range for usual price we would pay for a new
> "feature", that would be tolerable, I guess.

A possible (remote) reason for not doing this is in environments using ACLs that somehow want different access permissions on some functions vs. others AND where the platform does not have the ability to separately secure links vs. objects. I don't know of such an environment, but you never know. I know it's a stretch, but I can see security-types being worried about this. I do know of environments where /usr/local/lib is secured differently from /usr/local/bin to prevent inappropriate .so loads on a selective basis, so there's that. Again, this is a stretch. As long as we continue to have a method of forcing the expensive way for the paranoidly inclined ;)    -- not meaning offence to those, of course.

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



