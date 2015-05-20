From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 14:06:59 -0700
Message-ID: <xmqq4mn7m00c.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
	<vpq382rkvzf.fsf@anie.imag.fr>
	<d21002e0fa92b03c3d417c8996328563@www.dscho.org>
	<CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
	<20150520182218.GD14561@peff.net> <20150520183115.GB7142@peff.net>
	<xmqqlhgjm19z.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY7wg1JjshwZOtWhm_0qP=CBQqvhqayZpvhu35WuMhxWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:07:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvBCm-0000nx-VK
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbbETVHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:07:03 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37674 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbbETVHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:07:01 -0400
Received: by igbsb11 with SMTP id sb11so50160481igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=muL9GthRwAcnA1kgx58XXFEJJ4w7PvkUQPJszDBtmc8=;
        b=Rq2YFn34jDqZ3kXKGC2T53SatWLnFkYDSZRBPdFyR6fA24x7YCe0kJ0Cqixe1fhZ+f
         BBlysJxQPAvJdZavuYgUP9/xfcZT3mStcMpi8iG8ttX4/5D6IuN3VtoWla+W1MhZQV/6
         cW7pam/+3WMtHsAHiNoXMk4itFsGElXkZfmWGL0r585s0YzLMSg47X41ScuceQP9aNuW
         7pzbR2OzoMGVYw6Sh1Fp/WXyG/qlbck2VRpBf9xF6YZAxT8/nTsq5KGdNHxgI6B+ccam
         G1A7/c+ghy/1ihdHcVftbYxA397dSSCLCBbbwrt5D70XMTJ7cNsj6RyCM4dssM/epbEl
         CnzQ==
X-Received: by 10.43.151.83 with SMTP id kr19mr6248730icc.3.1432156021011;
        Wed, 20 May 2015 14:07:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id o15sm2447380igw.11.2015.05.20.14.07.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 14:07:00 -0700 (PDT)
In-Reply-To: <CAGZ79kY7wg1JjshwZOtWhm_0qP=CBQqvhqayZpvhu35WuMhxWQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 20 May 2015 13:57:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269525>

Stefan Beller <sbeller@google.com> writes:

> On Wed, May 20, 2015 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> So...
>
> maybe we need a command:
>
> Given this SHA1, tell me anything you know about it,
> Is it a {blob,tree,commit,tag}?
> Is it referenced from anywhere else in this repository and if so, which type?
> And if it is not referenced, nor an object, tell me so explicitely.

Let me add another to that list ;-)

  I have this prefix; please enumerate all known objects that share it.

I do not know the value of the first two in your list.  If it is a
known object, then you throw it at "git show", "git cat-file -t" and
dig from there.  If it is not known, there is nothing more to do.

I do not know if "need" is the right word, but I hope that you
realize the last two among the four you listed need the equivalent
of "git fsck".  It is an expensive operation.
