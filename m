From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/2] ls-tree: migrate to parse-options
Date: Wed, 18 Nov 2009 21:10:02 -0200
Message-ID: <a4c8a6d00911181510y66338536wb4b51b0df4788e76@mail.gmail.com>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
	 <1258173248-31059-3-git-send-email-bebarino@gmail.com>
	 <7vpr7hisc7.fsf@alter.siamese.dyndns.org> <4B024A89.2010108@gmail.com>
	 <7veinvcw7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 00:11:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAtfC-0003iJ-LL
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 00:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbZKRXJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 18:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbZKRXJ7
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 18:09:59 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39466 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbZKRXJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 18:09:59 -0500
Received: by bwz27 with SMTP id 27so1728247bwz.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 15:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z55FHEdonPcBsJtNFWEZi8LK8SZ6wJKg61DRQGurkII=;
        b=w7W/Vi0/HzJSQNFm3MDQn1b7GMuDg/kn3LaIX0nzmCbdCSKGF8QFcHENd6mYrbB18n
         15QwOUAFztpaqlAKU5QVEtsL5Y5mZCdsk4BF91vAaNusQTqMQhScEe399vF+ppxV3js9
         eH1SGL+dX532zRLSdE8bySe+bz+XJcfE4fI7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZVd4KeP50FopctuBmpEoe3P9uxGL6McvOYOOSJL1vrY4mA4B105iuIeiwfFh3aOoKI
         XyhdRiI44RwGLuIUoRNbYR7kn2/lLaHCsBbVN5KeEH5kSyew6e3ooKpindddcNfHIJh8
         GCDRw0ZuKs/IvS+AYiTF8lidzfo3NuYw+bYlY=
Received: by 10.204.7.153 with SMTP id d25mr1425194bkd.70.1258585802695; Wed, 
	18 Nov 2009 15:10:02 -0800 (PST)
In-Reply-To: <7veinvcw7w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133206>

On Wed, Nov 18, 2009 at 8:19 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Stephen Boyd <bebarino@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>>
>>> @@ -24,7 +24,7 @@ static int chomp_prefix;
>>> =C2=A0static const char *ls_tree_prefix;
>>> =C2=A0 static const =C2=A0char * const ls_tree_usage[] =3D {
>>> - =C2=A0 =C2=A0"git ls-tree [-d] [-r] [-t] [-l | --long] [-z] [--na=
me-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=3D<n>]]=
 <tree-ish> [path...]",
>>> + =C2=A0 =C2=A0"git ls-tree <options> <tree-ish> [path...]",
>>> =C2=A0 =C2=A0 =C2=A0NULL
>>> =C2=A0};
>>>
>>
>> Is it [<options>] or [<options>...] or <options> or even
>> <options>... though?
>
> Output from "git grep -e '<option' -- '*.c'" indicates that it
> should be "[<options>]"; thanks for spotting.

$ git grep -e '<option' -- '*.c' | wc -l
4

$ git grep -e '\[options' -- '*.c' | wc -l
42

$ git grep -e '\[<options' -- '*.c' | wc -l
2

Shouldn't be just "[options]"?
