From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v3 4/4] tag: use pgp_verify_function in tag -v call
Date: Mon, 4 Apr 2016 14:24:48 -0400
Message-ID: <20160404182447.GA6773@LykOS>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-5-git-send-email-santiago@nyu.edu>
 <20160403045600.GD1519@sigill.intra.peff.net>
 <20160404041203.GE28933@LykOS>
 <20160404133853.GB25404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:25:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an9BG-0003jw-RO
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 20:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbcDDSYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 14:24:51 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:32895 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbcDDSYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 14:24:50 -0400
Received: by mail-qg0-f53.google.com with SMTP id j35so159776248qge.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c78o63WCRaJfJsOL7lBOG7wsY9dbBSUXZddlzKqs9nQ=;
        b=IRthS7aCDBAQ4h2VBEfiBsnXDGBGOOIaSXrQk2o0IkxVpiv6iuCfZUZZUhjN37J1hM
         gR3aLb477FlABKbO/baWe4Us/JOllmCbFZtoLFpJGdUJGjUGfpUlgPkDkPw6ULgDC3ZB
         MXmhGeMGoTSubpdyc10HCjC4cauhvTR0O7noZy3rMhYE2z/MvtsNRjKZzJ4shxIslVqi
         akfpzhuH2Ow433ecPLS8Wf7ZOg8H/RLqCmCq3prmgbfPcw1ZmIGOvuRFPpTlncU0ulY6
         +GXE/R0gDQuwRowAItKo7JygJWkzY67vDMoT/piru3XJTdJmcLcLbu+I//B8YVTyQddC
         Dr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c78o63WCRaJfJsOL7lBOG7wsY9dbBSUXZddlzKqs9nQ=;
        b=JsTzM4Ujh7lqDHNs00QEtngfdtd3k0lRnsviBPsp4pZdbJ+XZeBewWLw9L9JVyNVvy
         21wWniAxfP8nPAsDt+I3mmxMQdYH48hltJsxwrEmVcRpSgwMJufNexLdqEtMCG3jag3e
         19NCBFYrhp8dhvWcQ3sHOlyU2IQ9sw3zazZwhREjHVQa+lwGJkRBYlq/Xb6/RC8MCcPa
         KevQkrRw5qEijINsZ1aI6lu+rsM7x9F7/l4hmZING/bcucbCGd48Dwhaq9ibHI/ZfsbL
         ReH2etIWZ4FYeMz0QJ63UbGyhUMPntRdKCgy8k33ywtpy6fdLwdja8E1xIH/Wfa5idMy
         DsQQ==
X-Gm-Message-State: AD7BkJInj7IUk3ktVpgXbf3xcS/seBhQdLh3vqWoDChDCYOPv3U9MIdQWoB8t92gd5/6AXRX
X-Received: by 10.140.161.198 with SMTP id h189mr44172312qhh.24.1459794289217;
        Mon, 04 Apr 2016 11:24:49 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id 2sm12874979qgi.33.2016.04.04.11.24.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2016 11:24:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160404133853.GB25404@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290715>

On Mon, Apr 04, 2016 at 09:38:54AM -0400, Jeff King wrote:
> On Mon, Apr 04, 2016 at 12:12:04AM -0400, Santiago Torres wrote:
> 
> > > As a side note, it might actually be an improvement for pgp_verify_tag
> > > to take a sha1 (so that git-tag is sure that it is verifying the same
> > > object that it is printing), but that refactoring should probably come
> > > separately, I think.
> > 
> > Just to be sure, this refactoring is something we should still include
> > in this set of patches, right? I think that otherwise we'd lose the
> > desambigutaion that git tag -v does in this patch.
> 
> I think it can be part of this series, but doesn't have to be. As I
> understand it, the current code is just handing the name to the `git
> verify-tag` process, so if we continue to do so, that would be OK.

IIRC, the current code for git tag -v hands the hex-representation[1] of
the sha1 to git verify-tag --- I believe that's related to the
desamgibuation issue I've seen people discuss.  I think this behavior is
lost unless we add this on top of the patch.

> 
> > I also think that most of the rippling is gone if we use and adaptor as
> > you suggested. Should I add a patch on top of this to support a sha1 as
> > part for gpg_verify_tag()?
> 
> Yes, though I'd generally advise against a function taking either a name or
> a sha1, and ignoring the other option. That often leads to confusing
> interfaces for the callers. Instead, perhaps just take the sha1, and let
> the caller do the get_sha1() themselves. Or possibly provide two
> functions, one of which is a convenience to translate the name to sha1
> and then call the other.

I think the former sounds easier. I can replace the name argument and
move the sha1-resolution code to in verify-tag. git tag -v already
resolves the tagname to a sha1, so it is easier there.

Does this sound reasonable? 

Thanks!
-Santiago

[1] https://git.kernel.org/cgit/git/git.git/tree/builtin/tag.c#n109
