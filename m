From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 01/10] sequencer.c: remove broken support for rfc2822
 continuation in footer
Date: Tue, 22 Jan 2013 02:21:47 -0800
Message-ID: <20130122102147.GD8908@elie.Belkin>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
 <1358757627-16682-2-git-send-email-drafnel@gmail.com>
 <20130122075413.GB6085@elie.Belkin>
 <CA+sFfMfERgGbf58LjOfAhhO_-YLu+yo+L-vYMuAuOUaP90yvgA@mail.gmail.com>
 <20130122101208.GC8908@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 11:22:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txazg-0003PQ-GV
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 11:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab3AVKVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 05:21:54 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:64630 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab3AVKVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 05:21:53 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so3971204pad.37
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/g3Ypjx3SRnNrXULBmWOec6T7m8y0yK7GNvGkMrRBCo=;
        b=QopEitjXsFPovWlTaNTVrbMJC9Jr0tQWX0npzpy1b0kpfkpMHLQNExgkV6xPkglZ+c
         MFnyurFSAI0USgvU8z/FcmdKlCU6cysZcffUBPKfMxPtY5QUUKEfAW6sw/7bFsOsD+vR
         xoSOSinnxhTch943hxx1padzm6fQGxUHhMcvuNQufyv1Ehfj9nJ3mWDiXwQtTTOVzE8Q
         9HVF9kuUP9qdtA/RuxlkuI8KdFlinPmRpMsJ2cnDgAdXdYB7Veh+TnkZ9kg4XuDuD21x
         h2JefDILtYqTF2IdDiFvU9D/dGV0mMCGfWy8KasnouWFz2tvamHC8OeoLGwzIsMq+/7e
         DUmg==
X-Received: by 10.66.84.232 with SMTP id c8mr55177503paz.8.1358850113328;
        Tue, 22 Jan 2013 02:21:53 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id qt3sm10499021pbb.32.2013.01.22.02.21.50
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 02:21:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130122101208.GC8908@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214230>

Jonathan Nieder wrote:

> 	line) instead of buf[i] is a whitespace character.  So for example, it
> 	confuses the following for a well-formed RFC2822 footer:

Luckily it doesn't, since the final continuation line is not followed
by whitespace.  I should have said:

	"... is a whitespace character.  The result is that any
	footer with a continuation line is not accepted, since the last
	continuation line neither starts with an RFC2822 field name nor is
	followed by a continuation line.

	That this has remained broken for so long is good evidence that nobody
	actually needed multiline fields.  Rip out the broken continuation
	support.

	No functional change intended."

I have no excuse, since you explained this all out loud to me a couple of
months ago. :)  Sorry for the nonsense.

Thanks,
Jonathan
