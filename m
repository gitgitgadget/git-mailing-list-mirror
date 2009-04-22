From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: What's going on here? Bad repo, no error locally?
Date: Wed, 22 Apr 2009 00:21:20 -0400
Message-ID: <3e8340490904212121q4bf2e25dsf5673bff764895c9@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 06:23:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwTz7-00068j-Rk
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 06:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbZDVEVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 00:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbZDVEVW
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 00:21:22 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:35413 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZDVEVW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 00:21:22 -0400
Received: by qyk16 with SMTP id 16so1806083qyk.33
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yz2Rm1ar7IV++AOjpTxZbHeFp85qzmo+qKZperw854Y=;
        b=el0LH2spV4emEU5wfk36Z1Bvzxdg2jSpxNyi3hAFKqMgYe0IrJldBGJnX8gsh1bJgq
         tMH5nRSsSpXgAHBQBXJtK6SLrcBEcfxd/BARzgmTmX7K00IQ/GqIDMKMmqkGk3WTfnMF
         Kvcu1qe3S0/09BWc8Z2Gjr0c7dBC9j0JumQzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l/XoI0NIHyFzkejT87iGZ7eIcxrCdeJiPYdjkSHKocyoyFUyKP7keKz46ooZGxKzX2
         XQMOwFW4qumKvKdOotmPBbCPNHXLYAqpM0bANkmPZiFhRXtNTuXl43zki4/N6iDKfQLq
         TpWfiKHLwRNMCPQi46kqVpbiKKHDAoXNrVW94=
Received: by 10.220.72.74 with SMTP id l10mr10048901vcj.71.1240374080454; Tue, 
	21 Apr 2009 21:21:20 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117167>

On Tue, Apr 21, 2009 at 8:18 PM, John Dlugosz <JDlugosz@tradestation.co=
m> wrote:
> Developer B runs git fsck --full, gets no errors but one dangling blo=
b.
> Does a push. =A0No errors.
> Now, on the upstream repo, I run fsck, and find a bunch of danglings =
(as
> always) and a missing blob.
> Any fetch from that repo will fail, due to that missing blob.
>
> What's going on? =A0How can I fix his local repository, other than bl=
ow it
> away and start over, and copy his current files over and rebuild the =
few
> commits of interest?

Extract the object on developer B's workstation:
git cat-file blob <object ID>  > blob.dat

Copy it to upstream, then do:
git hash-object -w blob.dat

If all goes well, hash-object will give you back the blob's ID, and
the repository will fsck cleanly again.
