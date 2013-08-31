From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Sat, 31 Aug 2013 07:22:45 +0700
Message-ID: <CACsJy8DOx8Q5kLizfeP2AgDaD8+EDsQL9xtOGphrmgG=dAabcQ@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
 <7vhae7k7t1.fsf@alter.siamese.dyndns.org> <CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
 <CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
 <CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
 <xmqqeh9b15x6.fsf@gitster.dls.corp.google.com> <xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 02:23:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFYyF-0004IL-UC
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 02:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab3HaAXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 20:23:16 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33062 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3HaAXP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 20:23:15 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so2571036obc.34
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+9SGyKZeLJXySR9nAlLO82cWAp7Ymn0iw/p45aFkEWU=;
        b=noDWhYjd02f+MLasG5zM2EUUxd1DJ2yXxFDRE2U82jlhkAD8gZh2RACwtFQ0RDF0ky
         Np299AMYRB7gF30ErLMuevPAlbmoaOuM7SY+iaguZOZKlvT/AMO8N9VjXAxTvccG5DMO
         +eG8eJg9PRKsJJtwBFpgKQ1SMjDx7jFzKQMRLFPLs3uij0nGmQCcoUWEq2DDLivFCi49
         xUnZL69sVvt4uTXK5HUhphJMh18LRYp4+Pa9tmjAojDWF4Cl9uvDY0mLZdIMLpIV6t7w
         qo6TCXwR5rWJUpPW8Z0Bdy/CGY2t8i/52hG2z35H+7/SMz0fPJH86Zvxx1oQlrp0n5fg
         KnpA==
X-Received: by 10.182.134.229 with SMTP id pn5mr8402180obb.88.1377908595204;
 Fri, 30 Aug 2013 17:23:15 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 30 Aug 2013 17:22:45 -0700 (PDT)
In-Reply-To: <xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233486>

On Sat, Aug 31, 2013 at 6:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> +static int ref_excluded(struct rev_info *revs, const char *path)
> +{
> +       struct string_list_item *item;
> +
> +       if (!revs->ref_excludes)
> +               return 0;
> +       for_each_string_list_item(item, revs->ref_excludes) {
> +               if (!fnmatch(item->string, path, 0))
> +                       return 1;
> +       }
> +       return 0;
> +}

If you pursue this, please use wildmatch instead so it supports "foo/**".
-- 
Duy
