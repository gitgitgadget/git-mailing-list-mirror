From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 2 Dec 2009 18:04:47 +0200
Message-ID: <20091202160446.GA32667@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org>
 <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
 <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 17:05:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFrhM-0008Oy-KX
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 17:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbZLBQEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 11:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbZLBQEq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 11:04:46 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:54657 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZLBQEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 11:04:46 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 7C2EBC7DB4;
	Wed,  2 Dec 2009 18:04:51 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A018E278D46; Wed, 02 Dec 2009 18:04:51 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 30F5C158A64;
	Wed,  2 Dec 2009 18:04:48 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vy6llnar5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134343>

On Tue, Dec 01, 2009 at 10:35:58PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> I didn't mean the line count by "large".  I was referring to the size of
> change at the conceptual level.  As Daniel already explained, it has been
> one of the design assumption so far that there are built-in mappings from
> some common <scheme>:// to backend "helpers".

No implicit mappings from <scheme>:// to helpers existed before this series
(except for forcing in URL, which are different). Thus, any mapping had to
be explicit and built-in.

And if mappings http -> curl, https -> curl, ftp -> curl are to remain explicit
in main git binary, I would put them into table and build stub remote-curl if
NO_CURL is defined instead of special casing the error in main git binary
(but I consider that worse than just removing the association from main
git binary).

>From file system listing on this computer (note the I-node numbers, this is
on newer version of change than the one sent):

2068945 -rwxr-xr-x 4 Ilari users 1547231 2009-12-02 15:12 /home/Ilari/.local/git-testing/libexec/git-core/git-remote-ftp
2068945 -rwxr-xr-x 4 Ilari users 1547231 2009-12-02 15:12 /home/Ilari/.local/git-testing/libexec/git-core/git-remote-ftps
2068945 -rwxr-xr-x 4 Ilari users 1547231 2009-12-02 15:12 /home/Ilari/.local/git-testing/libexec/git-core/git-remote-http
2068945 -rwxr-xr-x 4 Ilari users 1547231 2009-12-02 15:12 /home/Ilari/.local/git-testing/libexec/git-core/git-remote-https

So instead of mapping explicitly, those are effectively mapped by filesystem
(that's after the fixes for next round that make helpers hardlinked instead
of copied).

-Ilari
