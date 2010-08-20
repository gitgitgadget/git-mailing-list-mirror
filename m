From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 1/5] parse-options: Allow PARSE_OPT_NOARG in integer
 arguments
Date: Sat, 21 Aug 2010 01:31:51 +0530
Message-ID: <20100820200148.GE6211@kytes>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-2-git-send-email-artagnon@gmail.com>
 <7vlj81awtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 22:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmXov-00060m-RE
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 22:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab0HTUDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 16:03:48 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60627 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0HTUDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 16:03:47 -0400
Received: by pxi10 with SMTP id 10so1343791pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CpoDR4LHpEr/DWwyHq8640JctPq7dyFNgYZjR3YUcLc=;
        b=PVD9wyuurtDJYkIZ7M1Xq2e2TIb90oaaR9ZwmAsTkVHD6no16Db8RWyNflJr3fIJ26
         3bOGLYNSr/fhSablgRkkfRJ8IhlvXv3GCbW0HXY5s2bXU6KAsZv8DtAudpcSkowJbtVP
         v7z7bxjkP+GZHqQZYRQLIZDLBQsRI/GEttgv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pdYLBePppK4NhXe5ffoHOoOMQAT8fUJbytGl+jpv/pTDdV/6AffsSu0/5lxFae3Uk5
         6K9K2V+NzADLfoyw7y6qXzJ6YFw6f+PyUIuAYX5rKflRFJC2PR3jOhqFN/MVcqGCHvUx
         D4BZMAaeksGU9GTPN8MZSRj+XCK+/lWXYaL5I=
Received: by 10.142.48.18 with SMTP id v18mr1501497wfv.102.1282334626671;
        Fri, 20 Aug 2010 13:03:46 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3656155wff.19.2010.08.20.13.03.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 13:03:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlj81awtc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154078>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > When the option parser encounters an OPTION_INTEGER argument,
> > PARSE_OPT_NOARG should imply that the default value should be used.
> 
> Sorry but why?
> 
> Doesn't NOARG mean "Do not take an argument, if you give me an argument
> that is an error"?

Oh, does it mean that? I might have interpreted the description in
`parse-options.h` too literally: "says that this option takes no
argument". So I'm handling the case when an integer option is
specified, but no integer argument is given.

> I would understand if this were OPT_OPTARG, though.

That case is already handled. The condition (opt->flags & PARSE_OPT_OPTARG &&
!p->opt) does the same thing.

> Confused...

Okay, let me explain. Let's say I want to have an option that takes an
integer argument, say `foo`. To set it to the integer argument 42, I
can say `--foo=42`. To set it to its default value, I could earlier
say `--foo=`. With this patch I can simply say `--foo`. Makes sense?

-- Ram
