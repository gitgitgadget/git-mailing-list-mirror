From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 17/20] transport-helper: change import semantics
Date: Mon, 4 Jul 2011 17:37:59 -0500
Message-ID: <20110704223759.GC8909@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-18-git-send-email-srabbelier@gmail.com>
 <20110619233822.GJ23893@elie>
 <CAGdFq_iTojuvVAdB6sC7-Kro9E49q_1Lfh87Yy4nR5BTdZ1eaA@mail.gmail.com>
 <20110704215859.GA8909@elie>
 <CAGdFq_hFQRTjRZBGZKBejpUqCCzo+wHWG69nM8=57peUBN9yjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 05 00:38:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdrmV-0005JI-JC
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 00:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab1GDWiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jul 2011 18:38:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45369 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab1GDWiG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 18:38:06 -0400
Received: by iwn6 with SMTP id 6so4746685iwn.19
        for <git@vger.kernel.org>; Mon, 04 Jul 2011 15:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h8sQNtYMACy5frgA/p8ZwwmUPArBU9rhHg7qr3d57Xw=;
        b=dfNKwM5yr8Tmk8CWzcQZQgw5E9Q8wlq0gvkPd6AdCM1D1q7AfjFaxS7BjbWAiIgOWs
         sqLewuF3eGhNHeYleW6Z24bkFCopVCppUh13nsQypXgD+qCUtZmDGW7tMpKSyDnMXi2V
         FTPJ3b4plKAE/aPFMRMIn1N/Q3m0wTTykwPOs=
Received: by 10.42.226.132 with SMTP id iw4mr7288087icb.21.1309819084713;
        Mon, 04 Jul 2011 15:38:04 -0700 (PDT)
Received: from elie (adsl-68-255-111-183.dsl.chcgil.ameritech.net [68.255.111.183])
        by mx.google.com with ESMTPS id y1sm6887239ica.16.2011.07.04.15.38.02
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Jul 2011 15:38:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_hFQRTjRZBGZKBejpUqCCzo+wHWG69nM8=57peUBN9yjw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176607>

Sverre Rabbelier wrote:
> On Mon, Jul 4, 2011 at 23:58, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> It would mean no change compared to the current behavior. :)
[...]
> With the only difference that currently that \n signifies the end of
> the entire stream, whereas now it will mean the end of the imports?

Exactly.  The git-remote-testgit part of the patch would be pretty
similar to what you have and could even go earlier in the series if
wanted (since it does not require transport-helper changes), while the
transport-helper part should be unnecessary as long as patch 15/20
"use the new done feature where possible" does not remove the \n in
its output (as discussed in its subthread).

Meanwhile I should probably implement a "capability done" as Dmitry
hinted, to make blank lines no longer act as a terminator as a way of
helping people debugging by hand that hit <ENTER> too many times by
mistake.
