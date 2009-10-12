From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC 3/4] git check-ref-format --print
Date: Mon, 12 Oct 2009 07:39:22 -0700
Message-ID: <20091012143922.GL9261@spearce.org>
References: <4AD0C93C.6050306@web.de> <7vws327wbp.fsf@alter.siamese.dyndns.org> <20091012052536.GA11106@progeny.tock> <20091012053141.GD11106@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 17:00:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxMJO-0002pL-9N
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbZJLOkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbZJLOkP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:40:15 -0400
Received: from george.spearce.org ([209.20.77.23]:49954 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbZJLOj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:39:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 40DD8381FE; Mon, 12 Oct 2009 14:39:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091012053141.GD11106@progeny.tock>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130025>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> +valid_ref_normalized 'heads/foo' 'heads/foo'
> +valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
> +invalid_ref_normalized 'foo'
> +invalid_ref_normalized 'heads/foo/../bar'
> +invalid_ref_normalized 'heads/./foo'
> +invalid_ref_normalized 'heads\foo'

What about '/refs/heads/foo'?  Shouldn't that drop the leading /?

I actually had someone enter that into Gerrit Code Review once,
exposing a bug I have yet to fix that permits that as a valid
branch name.  *sigh*

FWIW, I think this is heading in the right direction.  Rather
than teaching the UIs how clean up a name, give us a tool to
do the normalization and validation, and let us call it when
we get user input.

-- 
Shawn.
