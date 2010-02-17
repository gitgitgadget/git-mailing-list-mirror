From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Question about git rebase --onto
Date: Wed, 17 Feb 2010 18:46:08 +0800
Message-ID: <be6fef0d1002170246r2b5c444cpdfce0678531564dd@mail.gmail.com>
References: <4B6865A9.60603@obry.net> <7v636f7biw.fsf@alter.siamese.dyndns.org>
	 <4B686CAC.7020103@obry.net> <7vhbpx3it2.fsf@alter.siamese.dyndns.org>
	 <4B6AF9EE.3000205@obry.net> <7vr5p1gd2t.fsf@alter.siamese.dyndns.org>
	 <4B7BB604.20205@obry.net>
	 <be6fef0d1002170219j27c79877k830f8d853719ea2e@mail.gmail.com>
	 <4B7BC4A7.5070902@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Wed Feb 17 11:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhhQ8-0003GJ-SR
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 11:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831Ab0BQKqL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 05:46:11 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:51930 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab0BQKqJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2010 05:46:09 -0500
Received: by pzk17 with SMTP id 17so6148139pzk.4
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 02:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VtIrgWrj4Szf6D9c67FTiCyd104BAcS9M62pDU4OxzQ=;
        b=Tk6Ghi7AqYsCZ9SWiera5mXnMRjRxjz9X5tj7kRrmJegq7b8SVms/GJZW7d5fKOe4M
         KZL7kPVOn0b3arsDTkgZ+nPs+rTtjoav96FBpieVjZInq8IM5T0ci24Uwiffb7q8pily
         acumOSUmKMGEiPa5BTKyhUinuLou+ZWCpEgeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tB/A+HHQFGdCknQtNB3wFG4UfU4UlP2NpNyYuTZ4jHdb2wuafevIeyhUeWID1/wyeC
         QEn9xEh1SaSdKJ6qpRNJt3PwRqiMyijYJzN2POtjWiHwvgzUoc4G7PAYoC9uzxISkqSe
         xY13W4Gxq8LGCclJCNZAasd5IfiLNkVXLTrvM=
Received: by 10.142.247.11 with SMTP id u11mr5167910wfh.205.1266403568987; 
	Wed, 17 Feb 2010 02:46:08 -0800 (PST)
In-Reply-To: <4B7BC4A7.5070902@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140231>

Hi,

On Wed, Feb 17, 2010 at 6:27 PM, Pascal Obry <pascal@obry.net> wrote:
>> Why do you add the last parameter ("HEAD")? If I run the rebase
>> without it, it works fine (ie. not on a detached HEAD).
>
> Right, without the final HEAD it is working. But it ought to work wit=
h
> it too. Hence my report.

In your original report though, you didn't say "HEAD"; you used a
branch. I quote:

On Wed, Feb 3, 2010 at 1:49 AM, Pascal Obry <pascal@obry.net> wrote:
>
> It seems to me that:
>
> =A0 $ git co topic
> =A0 $ git rebase --onto master topic~2 topic

I'm not trying to nit-pick, but it does matter - "git rebase --onto
foo baz~x baz" and "git rebase --onto foo HEAD~x HEAD" are quite
different.

According to the docs, the last parameter <branch> specifies the
branch to checkout to first before the rebasing takes place.
Therefore, I believe the behaviour you're experiencing when you
specify "HEAD" for the <branch> parameter is correct - git does a "git
checkout $(git rev-parse HEAD)", so you start the rebase on a detached
HEAD.

--=20
Cheers,
Ray Chuan
