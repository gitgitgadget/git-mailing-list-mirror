From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of "packfile"
Date: Wed, 20 May 2015 15:37:23 -0700
Message-ID: <xmqqzj4ylvto.fsf@gitster.dls.corp.google.com>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
	<xmqqwq04745w.fsf@gitster.dls.corp.google.com>
	<20150519222427.GA994@peff.net>
	<xmqqmw0znjfc.fsf@gitster.dls.corp.google.com>
	<xmqqd21vnid6.fsf@gitster.dls.corp.google.com>
	<20150520194906.GA8421@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 00:37:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvCcE-0000Hm-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 00:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbbETWhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 18:37:25 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35760 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbbETWhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 18:37:25 -0400
Received: by iesa3 with SMTP id a3so50684232ies.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 15:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=I6k46zBbrFwJovrUTQPdCRTAnADfkCd4v+uoDkq91WM=;
        b=DJt1mfg7/+pXII40+3dTp6XXfHgQRYBsmTASTEJG8vXB+EfCMV3x14d+kgwrP0jjfp
         C+qV+4+KMKBKi5JFwa4ypD3pWI6SRy1czAgcAkHnpC0D6OyVahyqWshu+/3GKT3uw5fY
         RwzmBwX/myNLHqDSf+eMAopN6ArMZ6Bnm4l3EP8U1CfXecZJRC8TJrhc1RcetgD3VbcQ
         vwq1DGadlsEb1ESwKR5a4sDfSMiZtxt6acw9RmniUpkrK8uTiQITLWCo5aY0kRmOAF6U
         e+2VDsj/i2MsKNcAT5xTur6H2qwtT++waaww3rxzIlKKTijuUMEPIqR6DD4TnxY/z7As
         zzmQ==
X-Received: by 10.50.57.112 with SMTP id h16mr158661igq.35.1432161444703;
        Wed, 20 May 2015 15:37:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id v14sm2619031igd.12.2015.05.20.15.37.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 15:37:24 -0700 (PDT)
In-Reply-To: <20150520194906.GA8421@peff.net> (Jeff King's message of "Wed, 20
	May 2015 15:49:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269533>

Jeff King <peff@peff.net> writes:

> On Wed, May 20, 2015 at 12:45:09PM -0700, Junio C Hamano wrote:
>
>> One related thing is that there are few mentions of "idx file" to
>> refer to "pack index" (e.g. show-index and verify-pack documentation
>> pages); I think this was an attempt to disambiguate "pack index"
>> from "the Index", but as long as we spell it "pack index", I think
>> it should be OK, so while we are at it we may want to fix them.  We
>> can leave "pack .idx file" as-is, but rewriting it to "pack index
>> file" or just "pack index" may be OK as long as it is clear from the
>> context.
>> 
>> "git show-index" has this in SYNOPSIS:
>> 
>> 	'git show-index' < idx-file
>> 
>> It probably should become
>> 
>> 	'git show-index' < <pack-index>
>
> That makes "pack-file" make more sense to me. It is not "the abstract
> concept of a packfile", but "the file with the .pack extension" (just as
> "idx-file" is "the file with the .idx extension"). They are the same
> thing if you think about it, of course, but you might choose one over
> the other depending on the context.

Hmm, that is also true.

In any case, even though I merged these three to 'next', I think we
need to either revert 3/3 or do s/pack-file/packfile/ throughout the
pack-protocol documentation.  The original has something like this:

    The pack-file MUST NOT be sent if the only command used is 'delete'.

    A pack-file MUST be sent if either create or update command is used,
    even if the server already has all the necessary objects.  In this
    case the client MUST send an empty pack-file.   The only time this
    is likely to happen is if the client is creating
    a new branch or a tag that points to an existing obj-id.

and these are explicitly referring to what EBNF defines as "pack-file".
Changing them to "packfile" is simply wrong.
