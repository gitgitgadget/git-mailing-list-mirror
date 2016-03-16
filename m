From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] help.c: strip suffix only if the STRIP_EXTENSION defined
Date: Wed, 16 Mar 2016 22:20:04 +0600
Message-ID: <CANCZXo5m-SF5qHxEgEUSPMaNEkcrZD07qbyfcmMurLVmBDRw+g@mail.gmail.com>
References: <1458138449-26690-1-git-send-email-kuleshovmail@gmail.com> <CACsJy8ARrpu=7JJ0=viuNN0pN7wae8FWRN96EqtiH9bOF_vypw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:20:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEBR-0000eZ-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbcCPQU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 12:20:26 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:32806 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbcCPQUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:20:25 -0400
Received: by mail-lf0-f50.google.com with SMTP id h198so23080332lfh.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3p0CsJt+UL/QdfEE58cz6gzZWsGJn+rm42rDskoS8Vg=;
        b=xR/hja9AsBop1HwBSe2mcukntX8cz6aU2qs4DsLHbmOfrelUvB7tDekLQtYdEIjpnC
         mjbtSrPhF/vAa1uMRbEsM4smkWmBzKl9ZArAPLbeMgC1mZ9q9iURvxuBiUga2/mc6F+F
         gixYqMp+vy1NOt369rEvjzRhCD8x2P+Xv+gL0q4QOAWwaOXS3gPtUuXWR0ZI6NulqiuR
         V5O2CEms/W6z+ki0mBxNU/TZ5rvW9wHIIPAcIhFDWRhfiYESG7rWNAfiZEKvcVqPGKNL
         z2FvX+grZDG23GC9YUjjEl+U9Qh4M9sqoE2cYvZHU+7jszxGKYCwrmv9ZloIyn435si9
         RE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3p0CsJt+UL/QdfEE58cz6gzZWsGJn+rm42rDskoS8Vg=;
        b=PlQwQgJOCnzp9U/PYwJ2nBOYzApSs+vShhOIBSMykSchX0gNNJjBFRLhKtjpGsAGTq
         HyJx/SZjO5gWl2bBFBHRMm84cjA04nqMxaD3NTDMAwv3FYZcI5vwLhdHojVBfAxbWB5Q
         BZ3PbWWT76zbiHuzFghvVe5O2kkK7WCJtalhSa5vFtHtCy7rY3HSDSQtCo0TAAW2hr2z
         lOQrXn2qQwSwrvx29WMVGSvT32rEOmg4Mkifz99bQ3kS5cK3sDqYYuebJd+qHzEvwCSM
         ryV6b9UVzswa/4B3qm7hlR1KL+/CX5//4BtqdI1NE8rLPkUFuTXiIq0ccbMLZwqMnsMX
         IFsg==
X-Gm-Message-State: AD7BkJLtMI8anXrPzl6gbhZkTBETGoVRUTdw59YqM0ShMbiOfquN/mJSvgs4RzOdP4v7j2ZYMsfMVKJ/pTJFGQ==
X-Received: by 10.25.209.83 with SMTP id i80mr1895697lfg.74.1458145223412;
 Wed, 16 Mar 2016 09:20:23 -0700 (PDT)
Received: by 10.112.77.65 with HTTP; Wed, 16 Mar 2016 09:20:03 -0700 (PDT)
In-Reply-To: <CACsJy8ARrpu=7JJ0=viuNN0pN7wae8FWRN96EqtiH9bOF_vypw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288986>

On Wed, Mar 16, 2016 at 8:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Mar 16, 2016 at 9:27 PM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> We stripping extension in the list_commands_in_dir() to get
>> commands without '.exe' suffix. Let's do it only if STRIP_EXTENSION
>> is defined to not spend time for unnecessary strip_suffix() call in
>> this case.
>
> Unless the time saving is significant, I'm against this change. It
> makes it harder to spot compile bugs in #ifdef'd code that's only
> active on Windows (imagine somebody renames "ent" or change its type).
> If you can do something like strip_extension() in git.c, it's better.
> Or maybe just refactor that function a bit and share it with help.c

Yes, agree. Will think about this.
