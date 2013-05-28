From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 28 May 2013 09:28:16 -0700
Message-ID: <CAFzf2Xx2mMO5XJ8n1UsUMMpDvi+KMUt9DpRe80X4zpG=THxSPw@mail.gmail.com>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
	<20130108062811.GA3131@elie.Belkin>
	<7vip78go6b.fsf@alter.siamese.dyndns.org>
	<CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
	<7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
	<20130528091812.GG25742@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 18:28:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhMl7-0007St-9W
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 18:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934738Ab3E1Q2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 12:28:19 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:41516 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934576Ab3E1Q2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 12:28:18 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so7848601lbd.6
        for <git@vger.kernel.org>; Tue, 28 May 2013 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=rh18BCXG4j00pvm2YaQuHpSPrcRNn104RVmzI/MurL0=;
        b=wug9BcaU0arCaf5O0gEld90/2e8miq4rR7RS3DgSx1sj0Kq+9ji8VDVRweW2zdOQwr
         vobRx5Uqf8CeVzw1KEASBjF2Gr8pweGEU4hX+vruTsI3QvioBQ0/9FjQxKMNnYIyA6DF
         e/jUk/dnY/P3mrmhCWvJgVfONMM0VjkNAxK3Vih/0jCV6rBaIMXvgzLwRALDoQ9+n69K
         OWsFIaEVJYAlHDUZSyk2Iq19VYJhphvZxeZezr1oi54V+xVpWdF/ClLXcNwuMmSvZQaz
         OPh2TPiMLN3DSZBqPwaObsM2NK2vnrVlntWYGmY5zf5G/X4PCnovKG62tITrWiIbgJ0B
         XyRQ==
X-Received: by 10.112.137.230 with SMTP id ql6mr4446477lbb.28.1369758496570;
 Tue, 28 May 2013 09:28:16 -0700 (PDT)
Received: by 10.112.59.36 with HTTP; Tue, 28 May 2013 09:28:16 -0700 (PDT)
In-Reply-To: <20130528091812.GG25742@login.drsnuggles.stderr.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225658>

Matthijs Kooijman wrote:

> Did you consider how to implement this? Looking at the code, it seems
> the "deepen" parameter in the wire protocol now means:
>  - 0: Do not change anything about the shallowness (i.e., fetch
>    everything from the shallow root to the tip).
>  - > 0: Create new shallow commits at depth commits below the tip (so
>    depth == 1 means tip and one below).
>  - INFINITE_DEPTH (0x7fffffff): Remove all shallowness and fetch
>    complete history.
>
> Given this, I'm not sure how one can express "fetch the tip and nothing
> below that", since depth == 0 already has a different meaning.

If I remember correctly, what we discussed is just changing the
protocol to "5 means a depth of 5". The client already trusts what the
server provides.

Thanks and hope that helps,
Jonathan
