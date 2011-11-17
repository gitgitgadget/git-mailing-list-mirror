From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] pack-object: tolerate broken packs that have duplicated objects
Date: Thu, 17 Nov 2011 12:49:44 -0800
Message-ID: <CAJo=hJsB_V0n8af0BPZs+qyQ3pVqBrb1xv8qfpifKgUJO=shTw@mail.gmail.com>
References: <7v8vnfnv3g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 21:50:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR8uT-0003Zd-IX
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 21:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab1KQUuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 15:50:07 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61695 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167Ab1KQUuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 15:50:06 -0500
Received: by mail-gx0-f174.google.com with SMTP id b2so1617608ggn.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 12:50:06 -0800 (PST)
Received: by 10.236.128.226 with SMTP id f62mr232215yhi.104.1321563006212;
 Thu, 17 Nov 2011 12:50:06 -0800 (PST)
Received: by 10.147.167.10 with HTTP; Thu, 17 Nov 2011 12:49:44 -0800 (PST)
In-Reply-To: <7v8vnfnv3g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185608>

On Wed, Nov 16, 2011 at 22:04, Junio C Hamano <gitster@pobox.com> wrote:
> When --reuse-delta is in effect (which is the default), and an existing
> pack in the repository has the same object registered twice (e.g. one copy
> in a non-delta format and the other copy in a delta against some other
> object), an attempt to repack the repository can result in a cyclic delta
> dependency, causing write_one() function to infinitely recurse into
> itself.
>
> Detect such a case and break the loopy dependency by writing out an object
> that is involved in such a loop in the non-delta format.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks sane to me, thanks.
