From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 4/9] ref-filter: add support to sort by version
Date: Sun, 12 Jul 2015 16:09:20 +0700
Message-ID: <CACsJy8DYcTAB6OkpAf-5kQ0V09Jkw8KDTGbRvLRO4TVXAwK8Bw@mail.gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com> <1435232596-27466-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 11:10:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEDGr-0007Ab-M4
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 11:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbbGLJJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 05:09:50 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34958 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbGLJJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 05:09:50 -0400
Received: by igcqs7 with SMTP id qs7so39079114igc.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aVl0VcQOA2ynO+ohRi6Zw3Pex7wiKFQehCLyyYDHlbo=;
        b=SzZhz2T+sUKK06Mgr0UKiTKKlg/axe8sDas2mQWvu2R1vaMaeCwd+4csNiPB3xLPNl
         n3XOfyka5dY5vs6sgh51VaxNray3gcrTDR3Jb3OT0a6+Vg78isciA4l/Xzr8rvGXKgmB
         bCDd7EMoifmuq+rnyQNjZi+9UlyAWZfGRrEOY99MzXp8A5MgwfYFbKwPyBeOstnrsfr6
         SCZRx9a90i9Jf2YpQ7ae0khk9jNnAaMn9NVHsc+ejxRV8/rG/Gm5ecIBPsSC5c8TM6/M
         F1/OyhKmu94O5selEWxYSbhJH0/vkpbyLEAK179blKkxlCdJ21tB+oxDMKRcrnMt4+Fz
         9MLg==
X-Received: by 10.50.28.78 with SMTP id z14mr7106421igg.61.1436692189794; Sun,
 12 Jul 2015 02:09:49 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sun, 12 Jul 2015 02:09:20 -0700 (PDT)
In-Reply-To: <1435232596-27466-4-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273888>

On Thu, Jun 25, 2015 at 6:43 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add support to sort by version using the "v:refname" and
> "version:refname" option. This is achieved by using the
> 'version_cmp()' function as the comparing function for qsort.

If these v:refname and version:refname are from git-tag, you may want
to see [1]. I would say "version:" or "v:" is in the same class as "-"
(for reverse sort) and they should be parsed in
parse_opt_ref_sorting() instead. They should not be treated as atom
names. By stripping "version:" before pref_ref_filter_atom() is called
in this function, you make "version:" work with all supported atoms.

[1] http://article.gmane.org/gmane.comp.version-control.git/242446
-- 
Duy
