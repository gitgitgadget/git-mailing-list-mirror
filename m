From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [WIP] Shift rev-list enumeration from upload-pack to pack-objects
Date: Sun, 7 Jun 2009 18:47:33 +0200
Message-ID: <c77435a80906070947u9bf8ce9m9d59f86e5a5f18ab@mail.gmail.com>
References: <20090605054500.06A9D21C3F4@mail.utsl.gen.nz>
	 <alpine.LFD.2.00.0906051224510.3906@xanadu.home>
	 <c77435a80906070625i4daaa69bi134df765d7a77cdf@mail.gmail.com>
	 <alpine.LFD.2.00.0906071225060.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sam@vilain.net, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDLX4-0005Jx-3M
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 18:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827AbZFGQre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 12:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbZFGQrd
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 12:47:33 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:35823 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbZFGQrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 12:47:32 -0400
Received: by ewy6 with SMTP id 6so3535939ewy.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Wf0CRukkOfES/g3MKqg5IfGC2DOXV6pdABkmLk/7IaY=;
        b=rk8PSsp6wJByK1tOEhtOQCFT2jghkr7huX45GRc1un6PDvsjVxNVqKm2PQOvVCqhZf
         kTgwQHf4SRNxPOu16yMWDow6B8z6MkxE74hBD6AuagWniLVNifqWcXv9dAuVRJ1xA6LZ
         NOvc2tqtF9UgV8szk/nPBo3mACeqEFt0A0kV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=InqGNdbDV9vrqoJ6bKw+e3yz2Mi4uj/7H0oe49VpdibJefN0JkHUoJrdgFOr4qNe8D
         2ExK8M/dc6Gkll24V67bsSZGGbnER5G0Wogt4gbFbcecSUzsktJqkYtUOV86clmvq7mj
         GeLj+S5H6AWRI92jxcqnmFhPFZym2yEG3Z+Yo=
Received: by 10.216.29.213 with SMTP id i63mr2005942wea.90.1244393253820; Sun, 
	07 Jun 2009 09:47:33 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0906071225060.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120982>

crap, your right.  somehow I managed to miss that...

I'll go ahead and seperate them then...

On Sun, Jun 7, 2009 at 6:41 PM, Nicolas Pitre<nico@cam.org> wrote:
> On Sun, 7 Jun 2009, Nick Edelen wrote:
>
>> I'm using the --revs flag in pack-objects, which causes it to use
>> get_object_list(). =A0you'll notice, regardless of whether --thin is
>> set, this function still calls
>> =A0 =A0 =A0 mark_edges_uninteresting(revs.commits, &revs, show_edge)=
;
>> which sets uninteresting objects as preferred bases, which I'd think
>> would create a thin pack. =A0I could be wrong though...
>
> Look at the arguments passed to setup_revisions().
> When --thin is set, the --objects-edge flag is passed instead of
> --objects. =A0Now see what effect this has on the third argument of
> mark_edges_uninteresting().
>
>> as I mentioned in the comment and above, it's an easy fix, but even
>> then I wasn't sure what to do with commit grafts. =A0as use_thin_pac=
k
>> seemed to be predominantly set on shallow interactions, I just didn'=
t
>> bother seperating the cases 'normal but thick pack' and 'shallow
>> stuff'.
>
> Please do separate them. =A0In theory you could use thin packs with a
> relative deepening of a shallow clone. =A0In other words, !thin and
> shallow is a wrong association to make.
>
>
> Nicolas
>
