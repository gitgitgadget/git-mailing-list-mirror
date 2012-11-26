From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Mon, 26 Nov 2012 13:46:55 -0800
Message-ID: <CAGdFq_iLYHs_tUDRsT9X1J12vSp3TUoMJQVbjw4ZgxONL6tMCA@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
 <7vd2z7rj3y.fsf@alter.siamese.dyndns.org> <20121121041735.GE4634@elie.Belkin>
 <7vfw43pmp7.fsf@alter.siamese.dyndns.org> <20121121194810.GE16280@sigill.intra.peff.net>
 <CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com>
 <7v7gp9udsl.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1211261726260.7256@s15462909.onlinehome-server.info>
 <7vd2z0tfhz.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1211262024520.7256@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Max Horn <max@quendi.de>, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 26 22:48:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td6Wv-0001ta-Mf
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 22:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114Ab2KZVri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 16:47:38 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50584 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab2KZVrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 16:47:37 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so8342822qcr.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 13:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xdOoygW8vFj3NR56MlE7E4g0dIRG1Wt19A1xJPc0LpE=;
        b=JWw8Om4HIrUNfEuKGCZ3xxiXqf1JzXS+vD6kgoU96eK8Y1DxEZIsndFkeKEUaFjeJR
         Go7kzi7axP5tyWXgSjuwO35jMwqoBe6re0GdV6eM6bgvORrZ4apxcmQTGJvVNH28D56/
         E5fTElSQaPBx/C1KGJNf/m+isxTdh5a7vCzi+U1mmJiJxiFvPW0I/2srsCRj5OcMolZh
         YjyEumJFwxun0EPXPHzowzzYApuzaBKZjP27LKxKdPYfFUkLfUcM86Mh2A3lCC29h/ki
         5XKmdesF5JTNna4+tXevT/hvW7+o8DdfYH6NPsIyx8eEu1bsu4KAIbF2PhLFbqwfNyrr
         VKcg==
Received: by 10.49.29.103 with SMTP id j7mr15427932qeh.47.1353966455940; Mon,
 26 Nov 2012 13:47:35 -0800 (PST)
Received: by 10.49.34.234 with HTTP; Mon, 26 Nov 2012 13:46:55 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1211262024520.7256@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210502>

On Mon, Nov 26, 2012 at 11:26 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> We added rev_cmdline_info since then so that we can tell what refs
>> were given from the command line in what way, and I thought that we
>> applied a patch from Sverre that uses it instead of the object
>> flags.  Am I misremembering things?
>
> It does sound so familiar that I am intended to claim that you remember
> things correctly.

FWIW, I implemented that in
http://thread.gmane.org/gmane.comp.version-control.git/184874 but
didn't do the work to get it merged.

-- 
Cheers,

Sverre Rabbelier
