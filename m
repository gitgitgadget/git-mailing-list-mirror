From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] helping smart-http/stateless-rpc fetch race
Date: Sun, 07 Aug 2011 22:03:43 -0700
Message-ID: <7vbow01ols.fsf@alter.siamese.dyndns.org>
References: <7vbow337gx.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 08 07:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqI0G-0008NG-GT
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 07:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab1HHFDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 01:03:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947Ab1HHFDq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 01:03:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D98BD4B88;
	Mon,  8 Aug 2011 01:03:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1YQyArUnfDW5CtCZZZa6fn8LpBw=; b=JFvVfi
	ayyXbOdEew4Gh+N2A9Re1IOQyIzhacuHG8awVb2ijmip7mt2d3bWS6srbr4YhCYl
	+QGuJSItt4Dfthgol36u4VWCmiEk/VDhDNYZQ0SslMYnVkFamK0DFyVNFOHMDwWz
	jwbcggbnsobOgMwY7oEEmsFTS1R6GD9bvkG8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YLM8LEupJlA9wFIabCbROzUS7x45/rxt
	1RmcVBvG7TVP2kOTtktV1C8kYa/ZJRSDOc8CyegUMTH3RvX9ZYPzmttcxBFS6gIF
	dIgaEJmmVYuFcB/W8rh/X/kOU1Hq1tiEBnhjBJN7rpHC5V6axtx6pwizVTnW/PBZ
	U9rjckDzrWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0BAE4B87;
	Mon,  8 Aug 2011 01:03:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57DB54B86; Mon,  8 Aug 2011
 01:03:45 -0400 (EDT)
In-Reply-To: <CAJo=hJvdMCyU-5wzy0p1r+QJxXU=DJTE+Mu5G6pk9iAwAD51mA@mail.gmail.com> (Shawn
 Pearce's message of "Sat, 6 Aug 2011 14:05:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB19849A-C17B-11E0-A6FD-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178940>

Shawn Pearce <spearce@spearce.org> writes:

> Why a new --allow-non-tip flag? Why not always do this with the
> existing --stateless-rpc flag?

It certainly would be much easier from implementation point of view, but I
did it that way for two and half reasons:

 (1) It might make sense to give admins who run upload-pack not behind
     smart-http an option to allow fetching from a non-tip; and

 (2) It also might make sense to let admins who do run upload-pack behind
     smart-http force re-fetching when the race is encountered.

and the remaining half-reason was that I was too lazy to think things
through to refute the above two "might make sense" and convince myself
that they should instead be "is not necessary".
