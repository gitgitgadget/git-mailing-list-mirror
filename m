From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Thu, 4 Dec 2008 02:48:59 +0100
Message-ID: <200812040249.01374.jnareb@gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com> <7vy6yw95ln.fsf@gitster.siamese.dyndns.org> <cb7bb73a0812031620s2459f773q3db33971e3507b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 02:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L83MN-0007Vw-HA
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 02:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbYLDBtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 20:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYLDBtH
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 20:49:07 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:27804 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYLDBtE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 20:49:04 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1635519eyi.37
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 17:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lHahx4jx8g4spjP1+Y9BWoSA9VB0JrwzaFYOvhsa23c=;
        b=dvpQG350HuCV2lrHYJwIypaF60snuSJqCA4n2uczE6Fly4lXn8apProUC5CmJS8MPk
         nTFQSqPqRHec7xaTUtWSGeTl4BdDdOYEPS6Kay9RjE5xEml1PsqeEjiDKkNHtwCPVNoT
         dEGWukX/nNA/o+J1OeOJ12TbSnEZCT4jtQTHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HKdCtCrmgCtREHQsC+8pT10lLxTbID7Ol7JvDhWUTqOC5E0yhWb9XLCNSQUJpPjO7m
         aAEZHiyK73/2jPyTZphUYSbF4/2SvNkPa8DSIgjEl4AZMppqqmL52CHVGLY0cglLxAcL
         CxenFdCAe4OisxHo8UcfEJdWO1yrf2WaNaC5o=
Received: by 10.210.52.15 with SMTP id z15mr2977427ebz.101.1228355342167;
        Wed, 03 Dec 2008 17:49:02 -0800 (PST)
Received: from ?192.168.1.11? (abvo179.neoplus.adsl.tpnet.pl [83.8.212.179])
        by mx.google.com with ESMTPS id 7sm90030eyg.52.2008.12.03.17.49.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Dec 2008 17:49:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812031620s2459f773q3db33971e3507b2f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102318>

On Thu, Dec 4, 2008 at 01:20, Giuseppe Bilotta wrote:
> On Thu, Dec 4, 2008 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>> +
>>> +     # The maximum number of patches in a patchset generated in patch
>>> +     # view. Set this to 0 or undef to disable patch view, or to a
>>> +     # negative number to remove any limit.
>>> +     'patches' => {
>>> +             'override' => 1,
>>> +             'default' => [16]},

Errr... you need something like 'sub' => \&feature_patches for override
to actually work, I think.

>>>  );
>>
>> Looking at the existing entries in the %feature hash, it seems that it is
>> our tradition that a new feature starts as disabled and not overridable
>> (see 'ctags' in the context above).
> 
> I always assumed that the disabled default was related to how invasive
> the changes would be (to the UI or computationally-wise). As for the
> overridability, that's actually the only reason why it would make
> sense to put in the %feature hash ... otherwise a conf-settable
> $patch_max (as in v2) would have been enough.

Add to that the fact that this patch just adds the new view, like for
example in the case of 'snapshot' link, which was turned on... but fact,
it was by default not overridable. I would agree that it can be turned
on with low limit but not overridable in introductory patch.

>>>  sub git_commitdiff {
>>>       my $format = shift || 'html';
>>> +
>>> +     my $patch_max = gitweb_check_feature('patches');
>>> +     if ($format eq 'patch') {
>>> +             die_error(403, "Patch view not allowed") unless $patch_max;
>>> +     }
>>> +
>>
>> Should you have to pay overhead for the check-feature call even when
>> the $format is not "patch"?
> 
> Actually I wasn't sure if I could use my within the if block, and have
> the value visible outside (it's used further down when picking the
> options to pass to format-patch). And since it was used in the second
> patch anyway to choose whether to add the 'patch' link in html view or
> not, I just put it outside the block.

You have to use _declaration_ ourside block, but assignment can happen
inside:

+     my $patch_max;
+     if ($format eq 'patch') {
+             $patch_max = gitweb_check_feature('patches');
+             die_error(403, "Patch view not allowed") unless $patch_max;
+     }

(Side note: doesn't it uses spaces instead of tabs for align?)
 
[...]
>> Other than that the patch seems quite straightforward and was a pleasant
>> read.  Thanks.

BTW. I'll try to review patch (and probably Ack) soon.
-- 
Jakub Narebski
Poland
