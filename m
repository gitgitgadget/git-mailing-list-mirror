From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] fast-import: insert new object entries at start of
 hash bucket
Date: Tue, 23 Nov 2010 12:19:56 -0600
Message-ID: <20101123181956.GG12113@burratino>
References: <20101123075348.GA10367@burratino>
 <AANLkTikK+vO2fLseChD8iccA0=M0FXp6TmWAPeaK9v+R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Raja R Harinath <harinath@hurrynot.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 19:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKxTT-0005OZ-J4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 19:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab0KWSUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 13:20:09 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63359 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab0KWSUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 13:20:07 -0500
Received: by vws13 with SMTP id 13so4424539vws.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 10:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IhcHX4nIRitSWUC3riryiu/UCfsVpJGGe/IhoIITwws=;
        b=PYm9x9XlBcf48dUae2YsDaP9MT8ONp80RrMB45obMm+Rhw0vU/cyzCySDR+Yp/+fia
         KtNRX+LOxAmmYGZgxM1A4z7axBqsIQnnDcpXzBFh+WiRxtJVGPt6ZMfef221lew/QVAX
         +pZztY1pwbZsaJggAM4aLONmoZ4nq1UFi/6NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PeUX2f2BjWDTC+lN4tzzaoTk5PUnCkEyZQUmHz2Ivw2fsjYO9SJ791P89ruPAJGmH+
         jrbFoCXjHh03/AQr6SkOCV6aCIif4WGetoypNNLXyArS04DGPvyUmzozWJDR5J7D97DA
         SCk8KibCKrehkIFcEYjpFdj2lvLr53fzZLnUQ=
Received: by 10.220.181.72 with SMTP id bx8mr2036004vcb.158.1290536406913;
        Tue, 23 Nov 2010 10:20:06 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id h28sm1414857vcr.19.2010.11.23.10.20.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 10:20:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikK+vO2fLseChD8iccA0=M0FXp6TmWAPeaK9v+R@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162002>

Sverre Rabbelier wrote:
> On Tue, Nov 23, 2010 at 08:53, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Thoughts?
>
> Are there (m)any non-artificial cases for which this slows things down (a lot)?

If a very common blob (e.g., the empty blob) is in the same bucket as
a few uncommon ones, it is likely to be inserted first and this would
slow down access to it.
