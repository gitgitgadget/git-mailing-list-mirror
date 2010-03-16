From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH/RFC 01/12] commit-tree: allow indirect tree references
Date: Mon, 15 Mar 2010 20:44:12 -0400
Message-ID: <ca433831003151744j80c5421n9cd1f310687dace3@mail.gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com> 
	<1268455984-19061-2-git-send-email-lodatom@gmail.com> <7v634z7uke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 01:44:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrKti-0000zQ-I5
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 01:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934505Ab0CPAod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 20:44:33 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:52491 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932779Ab0CPAod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 20:44:33 -0400
Received: by yxe29 with SMTP id 29so1719710yxe.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=H6wu2tHzJQAXnyjk2Y0i1ePJ/uiyld5Ieer7Plq3T/c=;
        b=B+ZeNIrWTzn30scKgkuV/ej9TlgKyUNSrX/OiGZeInYFNDGsB1zstduP7/5Tm/+Ssc
         TohWxDN85wUjZyPZe8Xiv2IkIBU6Vqbbm3TH60+mAT6iEEhUQ9Z7x0LfnBTm1IX5ZeQ0
         OOR0crHSqX6p4fHwFngs2lTn1IKXMFRcnhgOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=J53zOO6egI8OfaKAYx7QKkh483e2if50ZR/Nobu//5aNj0rlLD/zbijdSrmHDCPSiR
         u6B70Iw10wEswtfYXQ235H6+d4hVoGdNSsy5JQU7WWPHDPmghxdyY2YfPGD0STuLjVUO
         15y8TN+IN02TZCsD3LnNoF01TaF7tLYytV4SM=
Received: by 10.91.21.25 with SMTP id y25mr2815878agi.19.1268700272182; Mon, 
	15 Mar 2010 17:44:32 -0700 (PDT)
In-Reply-To: <7v634z7uke.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142284>

On Sat, Mar 13, 2010 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> 'git commit-tree' was the last remaining built-in to accept a <tree> but
>> not a <tree-ish> (an indirect tree reference through a commit or tag
>> object.)
>
> Historically we deliberately chose not to DWIM things down to tree for
> this plumbing command to catch mistakes by Porcelain scripts
> (e.g. arguments given in wrong order---the order of commit-tree's
> arguments are, eh, unintuitive).
>
> I do not think that matters much anymore---I do not think this patch
> is unsafe.

I thought about that, but upon investigation, the _only_ command that
doesn't DWIM with respect to object types (<tree> or <commit>) is
commit-tree.  So, I thought it might make sense to treat this like all
the other commands.  On the other hand, it may be a good idea to keep
this special for safety.  If so, then I would just amend the
documentation to note that it does not automatically dereference
commit or tag objects.
