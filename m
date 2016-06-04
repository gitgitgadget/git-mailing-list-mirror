From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Fri, 3 Jun 2016 21:53:02 -0700
Message-ID: <CAPc5daXQsWWuaune6w6_9vd_iywwjpXEUoJ3MoKntjenwCAH2A@mail.gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com> <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com> <20160603170621.GA3858@sigill.intra.peff.net>
 <CACsJy8DV5aqsxM9+QZ+5d2fMLYF4foBnAxmyiYHOLtqzvS3QGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 06:53:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b93aU-00046O-Rz
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 06:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbcFDExX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 00:53:23 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36641 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcFDExX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 00:53:23 -0400
Received: by mail-yw0-f195.google.com with SMTP id l126so13134489ywe.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 21:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Gif5pnV81W+sXtc2uelM/1fJzlvBexeQOghjTPOaFt4=;
        b=yRrHqEe6hrORM9rQlgluBW7+xbq5lysVwHyJ6Vq/apCEIFPYKx6Rmew4XHa5bK/uqP
         60pgCrAHmhqBG8K3gZ61N7BMTM2KnZr6+tXG6xNLAN/A4ivQ3n4S4/EPaR5lTLAG61Ly
         FceaQMuNPDInnM+GkcSKlAr77YIJLX8OfHkX4YI4vqWzHEM6m/Yi43gqfZ1OaAlnfyhy
         9DAbOcFYUWBMEKELTBVt2VA+wstn93vIUzFtdkhn7EdMWXKyKxzpoKWNwxC+pjJIG8US
         gtYf+qD5GPY19f7V1/ncT6gpaa864DV6C0TJ+CVa6KJ1bluo46Xy6fXtyNsQpdzIcXCA
         6mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Gif5pnV81W+sXtc2uelM/1fJzlvBexeQOghjTPOaFt4=;
        b=lJA01e5xrEEvG1w8obvcPooauiZSQvOtKqNpMV66C72NBx5Se+DY1aJ1Sww4MnkTp1
         bnII9Uy0/+uJnVjgjREr9nYNTZGc4CU/49Yr2LTIhaiT/iGiioCg++1tY8ydhN8Sea0f
         JBxCnY5WlLwDHGpR4qU1BpoodI/VBYR3rL9YZrZ1oPAGoDuUkcdzUvZIhGbJhzsdWsZe
         QBugF00ZHf5zPZGJ9W39GQ9quDUj2M/VSO39ahTMwivCPg8P2NsL8AzOyeSpKohL0F/H
         N2jnbQyQq1+WfGZUaRp1LaCFlXI/0vMpmJJiPk8ARhjmOVJ8V1DPEOD7QyDhSMhtXEnH
         4RvQ==
X-Gm-Message-State: ALyK8tLKtrMMLJ3zEZ0jwgf6WI78+NTkLqytsa1AgNxmqhcsOW4KfrR8QdUyotRo45mkEgE34U9BWBFdxCDPZQ==
X-Received: by 10.37.111.69 with SMTP id k66mr4586419ybc.47.1465016002004;
 Fri, 03 Jun 2016 21:53:22 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Fri, 3 Jun 2016 21:53:02 -0700 (PDT)
In-Reply-To: <CACsJy8DV5aqsxM9+QZ+5d2fMLYF4foBnAxmyiYHOLtqzvS3QGQ@mail.gmail.com>
X-Google-Sender-Auth: _ialu-t7zu6YR7l64Y4A-tG64dg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296440>

On Fri, Jun 3, 2016 at 4:52 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> A placeholder can still keep the variable part at the end, e.g.
> "refs/$/head -> pull/123"

I somehow like this very much.

A more typical "their topic went to remote-tracking namespace under 'origin'",
aka
     topic -> origin/topic
aka
     { -> origin/}topic
would look like a more concise
     topic -> origin/$
without the funny {} notation.
