From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Wed, 5 Sep 2012 17:28:39 +0700
Message-ID: <CACsJy8D23tDa3SJO6yegHFs2hT+bTr6mLTn16ZU3kiT1dtj4vw@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-6-git-send-email-git@adamspiers.org> <CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
 <7vr4qhbt3d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 12:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9CrG-00047b-Ng
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 12:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab2IEK3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 06:29:12 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60565 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab2IEK3K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 06:29:10 -0400
Received: by ieje11 with SMTP id e11so772942iej.19
        for <git@vger.kernel.org>; Wed, 05 Sep 2012 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aOVzVgmhOIlXwoAZzT/GWAtRGx1tpGnfMENzODuiscU=;
        b=pevIt2d5NG5Pxb9eYf4dN4KCGnk1wX+NJGJueLkMSVLm/5XizXBXcru5EB9Rskg6LJ
         u5rCGwIvna73BladrW53NnX6MYX9r9iIdN/ifWO2wNMsBlomg0/+1kuSieUREaJAqg8l
         01gedqQDUgAcBfhwnWmm59gnwsZRwIN3zXDb5AZL4NouOMWJTIcAT9uZqkLVMo0pMPC2
         CFSPMBM88nkewSoutJTTTe5BiJ25mNAOBjWw0pnHwtHYJrus/oN/OqGu+Mfe75OI4sqP
         kr3941wViQWWFsZyjIBm6Sfm3aayt7GwxCjn3N87r5JrRqXv7hpi9Ajg7rP0nX9zv9ch
         enMg==
Received: by 10.50.220.194 with SMTP id py2mr17387460igc.15.1346840950086;
 Wed, 05 Sep 2012 03:29:10 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Wed, 5 Sep 2012 03:28:39 -0700 (PDT)
In-Reply-To: <7vr4qhbt3d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204809>

On Wed, Sep 5, 2012 at 12:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
>>>  extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
>>>  extern void path_exclude_check_clear(struct path_exclude_check *);
>>> +extern struct exclude *path_excluded_1(struct path_exclude_check *, const char *,
>>> +                                      int namelen, int *dtype);
>>>  extern int path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
>>
>> Exported functions should have nicer names than *_1. No idea what are
>> better names though, maybe exclude_path?
>
> Which part is better?
>
> Just like between path_excluded_1() and path_excluded() nobody can
> tell how they differ (except perhaps the former smells more special
> purpose thanks to its funny name) and wouldn't be able to tell which
> one to call without looking at their sources, it is hard to tell
> path_excluded() and exclude_path() apart.  In a sense, that pair is
> even worse as there is no hint to suggest which one is more exotic
> between them in their names.

We could introduce exclude_path() and kill path_excluded() then. There
are just about 5-6 call sites to replace.
-- 
Duy
