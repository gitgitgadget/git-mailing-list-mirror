From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 02/26] refs: make repack_without_refs and is_branch
 public
Date: Mon, 19 Oct 2015 19:16:36 -0400
Organization: Twitter
Message-ID: <1445296596.3418.31.camel@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
	 <1444938410-2345-3-git-send-email-dturner@twopensource.com>
	 <56209A81.1060706@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 20 01:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoJfZ-0006lr-52
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 01:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbbJSXQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 19:16:39 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33203 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbbJSXQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 19:16:39 -0400
Received: by qgeo38 with SMTP id o38so470360qge.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 16:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=tJgyqvv2YDrloVi3SC+J7oDvPRkELnAU5rP/aUf1MhI=;
        b=hfedqR99ph2POS2OCtYN4QTFx7k/wWnlgQX7G7imTfecNtcaT3vgy2wJubik4I8DF8
         JvnDRf9ybOmsQb13rUn9oKPadiBXSdLtN5zYkMuy3H2NoaoBiLlRre2O1E3bIv9/82Bo
         XkN5tCgJahvD+vIdqDmTtGQ34yWuSh79fJfGPjzpnI27PzTK6nAeuMMh6W69IiANFXCT
         qfxW44V0E82LAo1ddQwqdUSn/JYWeXms0HFHM2m8BouSSFwNYEE4fnsboviG3uZ5S4kX
         7m1TKTlF1uC2aXsr04VKyVW7Y9pvBz2tCBxd6hgMUmlatVEilZtzHvaTayXXyaY87sQq
         t9aA==
X-Gm-Message-State: ALoCoQmBf52zSsfPZ8uF0+qRHq1r8FCi4XxY5WZqXj0bfrNGqP+Pn8RCfA1D3nV/3UB60uP/4PvJ
X-Received: by 10.140.96.71 with SMTP id j65mr31222qge.92.1445296598416;
        Mon, 19 Oct 2015 16:16:38 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 206sm41145qhq.39.2015.10.19.16.16.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2015 16:16:37 -0700 (PDT)
In-Reply-To: <56209A81.1060706@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279897>

On Fri, 2015-10-16 at 08:34 +0200, Michael Haggerty wrote:
> On 10/15/2015 09:46 PM, David Turner wrote:
> > is_branch was already non-static, but this patch declares it in the
> > header.
> 
> The commit message no longer reflects the patch.
> 
> > Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  refs.c | 5 +++--
> >  refs.h | 2 ++
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/refs.c b/refs.c
> > index fe71ea0..84abc82 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2816,8 +2816,9 @@ int pack_refs(unsigned int flags)
> >  
> >  /*
> >   * Rewrite the packed-refs file, omitting any refs listed in
> > - * 'refnames'. On error, leave packed-refs unchanged, write an error
> > - * message to 'err', and return a nonzero value.
> > + * 'refnames'. On error, packed-refs will be unchanged, the return
> > + * value is nonzero, and a message about the error is written to the
> > + * 'err' strbuf.
> 
> ^^^ ?
> 
> It is preferable for docstrings to be written in imperative form, so in
> my opinion this is a step backwards...
> 
> ...literally. Your "new" version comes from an older version of Git; it
> was changed in
> 
>     79e4d8a9b8 repack_without_refs(): make function private (2015-06-22)
> 
> to the imperative form.
> 
> Assuming you are using `git-format-patch` to prepare your patches, it is
> always a good idea to read over the prepared email files before sending
> them to the ML, to check for bloopers like this.

Sorry about that one.  It's hard to keep track of what all of these
patches do -- especially the ones that were rebases of Ronnie's.  I've
fixed that and 03/26 as well.

Do you have comments on any of the rest before I re-roll?  
