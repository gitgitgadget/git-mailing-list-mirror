From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Wed, 21 Mar 2012 07:28:24 -0700
Message-ID: <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 15:28:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAMWy-0002xg-33
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 15:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031222Ab2CUO2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Mar 2012 10:28:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44622 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030924Ab2CUO2p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 10:28:45 -0400
Received: by dajr28 with SMTP id r28so1673614daj.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=olBnlfHBrQ7e8/WSAfVDyo0MgbHrZEnXJjgaZ9slpas=;
        b=azZMNTVqUzBYLeZ4LbD/JhqRY9GpGEM0fdDNl1PFYXd95NBGVdAa9G67VhGujkBEj3
         vBWyc9NaUpap2VsIEp1s9JIR7eHLHCnSf3YqG00r2eVYsXxlYU/53s4DyReKe2NIfxEJ
         R5qcModaDeWcmVNQL+4kicFszAmC/lalQ8Mrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=olBnlfHBrQ7e8/WSAfVDyo0MgbHrZEnXJjgaZ9slpas=;
        b=SduxNMErjEelexpn9wwBO4/TFvLXFUfDw9nKH8NLvx7YMbCY5TOfCk5w8H/fkEW3SI
         h7b4//Hr9rIJqqSdyDgTpUv6YmCnql3uIdE/P5k/zdQkSXTmjRqh2bK9Vh8XHdmleIax
         wjB0oXuScTZZtJ3245kzL5U0xBGKtUnX5LeGCrP5dnH+H62v70N7G0qh0h6NpAMzxJpe
         L0lG0s1KSJoSedne0eU+Um+NsOtfFOZ+Ldq5rq7uUPlW288oABHvSHgLxZJn3/SePdPf
         qRzUEApIBLhms2jKnEQeriKh4gFVlOxEYkdatti/0isf/b3cTntp7chnq9AT4Eytas1k
         0PDw==
Received: by 10.68.230.195 with SMTP id ta3mr11512538pbc.149.1332340124671;
 Wed, 21 Mar 2012 07:28:44 -0700 (PDT)
Received: by 10.68.237.201 with HTTP; Wed, 21 Mar 2012 07:28:24 -0700 (PDT)
In-Reply-To: <4F69B5F0.2060605@gmx.net>
X-Gm-Message-State: ALoCoQlTDkJZsG+Ry7xaRl/LwPvr/kfNtzQ6jwMTXdGykVeyEhvTp1guJn9ZissLMIagza3eIISN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193580>

On Wed, Mar 21, 2012 at 04:05, Ivan Todoroski <grnch_lists@gmx.net> wro=
te:
> On 19.03.2012 03:44, Jeff King wrote:
>> Yes, I think that would work. You'd just have to take care to pass t=
he
>> residual buffer (i.e., what is left in your input buffer after you
>> notice that reading the list of wanted refs is finished) along to
>> the git-protocol code. =A0So it would require a little refactoring o=
f
>> get_remote_heads, I think.
>
>
> Would it be OK for fetch-pack.c to use the packetized format (pkt-lin=
e.h)
> for reading the list of refs from stdin?

This is probably the easiest way to implement the sneak-into-stdin
patch. Use a pkt-line for each argument that should have been in the
argv array from the command line, and a flush pkt to terminate the
list.
