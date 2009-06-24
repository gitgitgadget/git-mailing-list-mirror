From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: [PATCHv5 3/3] gitweb: gravatar url cache
Date: Wed, 24 Jun 2009 16:06:33 -0700
Message-ID: <8c9a060906241606x281f4d33ne5e4999a50ee8128@mail.gmail.com>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<1245878183-2967-3-git-send-email-giuseppe.bilotta@gmail.com> 
	<1245878183-2967-4-git-send-email-giuseppe.bilotta@gmail.com> 
	<7v63elqoig.fsf@alter.siamese.dyndns.org> <cb7bb73a0906241546x6b6164e7w4e6c6601d1119032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 01:07:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJbYU-0005kr-8m
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 01:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbZFXXGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 19:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbZFXXGv
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 19:06:51 -0400
Received: from mail-pz0-f189.google.com ([209.85.222.189]:33286 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZFXXGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 19:06:50 -0400
Received: by pzk27 with SMTP id 27so921859pzk.33
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 16:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Y1LBezN8Vpygrl+1bEFFMoIpkh+wGCSaCwECbhGAdiY=;
        b=Jvo52aIJdMLrQw/qk8gsKb+5CLydiwy79Psqy0ZfqNB/X6I0qXnDPF9Q7XaCoG0XK0
         QgjLHI1F6Zgy3qsoewfFMeOw+JjsZV5Nk7onGBylxKI2WmShzVNGRtvXgRovGhEjMwrs
         mi+ZwlmsBi/g2nQDIhwF6qeB/9/a+IYlD3mLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XOv/zipfDpcj9lRfVLOjr9R6IFg0Qyf1In1dyhgyaxfWjED8rz0j3inoO51bkv/m3K
         2gG6AXyjiC+f8Qx/uIHMLTsqU5BQPVeYUsAFxomFCyGejPrQA8MB8NK6/pUTaTUmkiMd
         +eL5n3PYas51F2HzCuX/UdRH0riHzHQYketuY=
Received: by 10.142.174.20 with SMTP id w20mr593361wfe.39.1245884813139; Wed, 
	24 Jun 2009 16:06:53 -0700 (PDT)
In-Reply-To: <cb7bb73a0906241546x6b6164e7w4e6c6601d1119032@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122167>

On Wed, Jun 24, 2009 at 15:46, Giuseppe
Bilotta<giuseppe.bilotta@gmail.com> wrote:
> On Thu, Jun 25, 2009 at 12:02 AM, Junio C Hamano<gitster@pobox.com> wrote:
>
>> I think the cache is placed at the wrong level (it doesn't have to be a
>> GRavatar_url_cache, but can be a general avatar_url_cache).
>
> I'm not sure about it. The URL depends on email and size (can you use
> arrays as hash keys in Perl?) , and the email part might be the same
> but the size part might differ across separate calls (in theory; in
> practice avatars in a view are presently all the same size; but for
> example if we were to autodetect email addresses in commit messages,
> we might have both single- and double- sided avatars in the same
> page). By hashing on email+size only we would lose the benefit of
> cache when using the same avatar at separate sizes.
>

You could have a hash key of "$email_$size", or something similar to
fake an array hash key.
