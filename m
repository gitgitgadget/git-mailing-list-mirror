From: Shawn Pearce <spearce@spearce.org>
Subject: Re: how to keep git-fetch from running out of memory?
Date: Sun, 15 May 2011 13:37:27 -0700
Message-ID: <BANLkTi=+k_qh_RzuL73NPnEEcpA=0B8X_Q@mail.gmail.com>
References: <BANLkTinnOTr+PUzBMpx1DLcxs8CVWjy33A@mail.gmail.com>
 <BANLkTinRkePRMQzQS7k=3bSTxTJRVpG39Q@mail.gmail.com> <7vboz3pv7x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kartik Agaram <ak@akkartik.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 22:37:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLi4a-0003ZZ-2S
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab1EOUht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 16:37:49 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55074 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab1EOUhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:37:48 -0400
Received: by vws1 with SMTP id 1so2755123vws.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 13:37:48 -0700 (PDT)
Received: by 10.52.176.3 with SMTP id ce3mr5123516vdc.313.1305491867100; Sun,
 15 May 2011 13:37:47 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 13:37:27 -0700 (PDT)
In-Reply-To: <7vboz3pv7x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173664>

On Sun, May 15, 2011 at 13:25, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> However, that may still be insufficient. A big object must still be
>> allocated in memory in order to compute its SHA-1.
>
> I wonder if we can stream this?

If its a non-delta, yes. We already do this in JGit for blobs over
50M. (Trees, commits and tags are not streamed because we might need
to do fsck on them and the fsck code for these object types requires
the entire object in a single buffer.)

Its probably not a huge change to index-pack.c. But I haven't dug
around in there in a while. I wish I could say I will look at this on
Monday, but I don't have the time.

-- 
Shawn.
