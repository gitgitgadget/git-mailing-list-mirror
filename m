From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/16] Read index-v5
Date: Thu, 2 Aug 2012 19:45:58 +0700
Message-ID: <CACsJy8Co8warnQg+fKmXnO_wt=dTPBjRRe+Apic6-GBrTr_3rg@mail.gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com> <1343905326-23790-10-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:46:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwunT-0001KT-TN
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 14:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab2HBMqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 08:46:31 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:65180 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab2HBMqa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 08:46:30 -0400
Received: by ggnl2 with SMTP id l2so1368732ggn.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ha5cqZhnqbixm1OpuxFOvQyfGE9AqSX4Zllh92gZbsg=;
        b=ZZ48Mx170CqUPz6BZBOKQSOKXIm9Y8paPRF6pG+FiD8c3Uj9wg/b4PQenHdawPek0U
         fcQ9IhseNrbHDja79L59/cwo0Bzmhd9riiNZuI9xwPo3tWhzAf41dJKz9bFo4GlP4svP
         5b61hmk26/hhlr+UmcKJSaCf6zz/JOAzIgnsBuifE7SIiWYw3I2FLWuYSVS00LSIUwyc
         9tpcFtUW4vjgJHUM/CyQsxRTp8MDbie7SVde46GyELP173UVWJGzOkJ/Kg2eIkWcTKJQ
         rBgJWrhUZHEA2CWCfCzcf3BFBvPEqRNRXmXvdKeNpItUSbTDHmTjBiILS2HDkUSBuTea
         yJMg==
Received: by 10.50.188.134 with SMTP id ga6mr3508755igc.36.1343911589654; Thu,
 02 Aug 2012 05:46:29 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 05:45:58 -0700 (PDT)
In-Reply-To: <1343905326-23790-10-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202773>

General note. I wonder if we should create a separate source file for
v5 (at least the low level handling part). Partial reading/writing
will come (hopefully soon) and read-cache.c on master is already close
to 2000 lines.

On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> +static struct cache_entry *cache_entry_from_ondisk_v5(struct ondisk_cache_entry_v5 *ondisk,
> +                                                  struct directory_entry *de,
> +                                                  char *name,
> +                                                  size_t len,
> +                                                  size_t prefix_len)
> +{
> +       struct cache_entry *ce = xmalloc(cache_entry_size(len + de->de_pathlen));
> +       int flags;
> +
> +       flags = ntoh_s(ondisk->flags);

huh? ntoh_s (and ntoh_l below)? search/replace problem?

> +       ce->ce_ctime.sec  = 0;
> +       ce->ce_mtime.sec  = ntoh_l(ondisk->mtime.sec);
-- 
Duy
