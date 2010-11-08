From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Mon, 8 Nov 2010 13:56:01 -0800
Message-ID: <626BD1B6-4DDF-457F-B430-F15C891710E2@sb.org>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com> <1288878944-14066-1-git-send-email-pclouds@gmail.com> <7vvd4bu2pl.fsf@alter.siamese.dyndns.org> <15C4C111-824D-4657-B034-A1BE1DAD50D4@sb.org> <7v8w13r756.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 22:56:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFZhL-0006sV-IY
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 22:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642Ab0KHV4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 16:56:11 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45470 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab0KHV4J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 16:56:09 -0500
Received: by pzk28 with SMTP id 28so1153388pzk.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 13:56:09 -0800 (PST)
Received: by 10.142.135.7 with SMTP id i7mr5331119wfd.17.1289253369333;
        Mon, 08 Nov 2010 13:56:09 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm485361wfd.7.2010.11.08.13.56.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 13:56:08 -0800 (PST)
In-Reply-To: <7v8w13r756.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160995>

On Nov 8, 2010, at 10:40 AM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> Would this actually break any existing setups? The only ones that are affected
>> are ones beginning with ", which I imagine would be rather rare.
> 
> No regression policy means just that.  We try not to break "rather rare"
> people, only to add support for different kinds of "rather rare" setups,
> especially when the latter have working workarounds.

I'm still not convinced that the workaround is appropriate. If I have a file
named "file 1" that needs special attributes, then it is impossible to leave
those attributes unspecified for, e.g. "file.1". I'd have to set them on
"file 1" and then immediately unset them for "file.1". And as unspecified
behaves differently than unset, this can be a problem. Especially because if
I add any other files in the future that match "file?1" I have to remember
to go through gitattributes and re-set all of the ones already specified to
something appropriate for this file.

Sure, this is probably a rare case, but so is filenames beginning with a ".

Basically what I'm trying to say is, we already break one particular
"rather rare" setup. I would love to come up with a solution that supports
both setups, but I don't know if one exists outside of using a config
variable to control whether git attribute patterns support quoting (a solution
I am not particularly fond of for this case).

-Kevin Ballard