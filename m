From: Scott Chacon <schacon@gmail.com>
Subject: Mercurial on BigTable
Date: Wed, 10 Jun 2009 12:15:49 -0700
Message-ID: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1METHB-0002sg-TF
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 21:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758415AbZFJTPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 15:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757873AbZFJTPs
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 15:15:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:41880 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434AbZFJTPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 15:15:48 -0400
Received: by yw-out-2324.google.com with SMTP id 5so655174ywb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/FT5N0Smiy+p0nw1TUqgaxRgxWO/CJZ/GRVlEv4ycGE=;
        b=szeaADrfi4IJ3uRIVrNqT8T0xOvfUWfYmM3Df2u5TppkACGRWu3qMEbI7QRNzKEvxi
         SpxyAZ8CcmoQVo/Qiv1o6Wap6Vvp0NLcV8ZdSUCwIHPEwzEHE4vdXy4SJsBv+MOWW6WX
         Bbv1netTDGbyw1s3ZjTzynKyWo/QZgJo3+Hus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Gcxok9BrVnExM3iW2iMs3N7NwOQAl4gI1jrfdISiMGKim1f6zXcWm8Y3XPzYJJLd8g
         aXRRfjVS1fTkfTH+ObzhhgrFwM/8OZrCQpbh4u9OSzaZ5jajxFh9/Rf9EJL76nrdLY0/
         yRXfgq4OtDQ012VgChj93TEpDpV7DSbr7508w=
Received: by 10.100.141.16 with SMTP id o16mr1732009and.152.1244661349980; 
	Wed, 10 Jun 2009 12:15:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121295>

Has anyone watched this yet?

http://code.google.com/events/io/sessions/MercurialBigTable.html

It's kind of interesting - a Googler talks about getting Mercurial
running on BigTable.  What fascinates me is that if I'm not horribly
mistaken, it seems like they just threw out the revlog format entirely
and just store the data in a key-value store as sort of a Git-like
content addressable filesystem.  I had thought they were taking
advantage of the revlog structure somehow, but it appears like they
basically just changed the underlying data format to be much more like
Git and rewrote ah Hg speaking server on top of that.  They even
explicitly store the head values like refs instead of reading
childless nodes out of the revlog, which is what I thought Hg did.

Does anyone know how they do the graph walking efficiently with this
structure?  He mentioned it was about half as fast as native Hg, but
that seemed to be acceptable.  Curious if anyone had any thoughts or
information on this.  Shawn, are there technical reasons why this
works well the way they're doing it for Hg but would not for Git (like
in the repo MINA based server)?  It looks like the data structure and
protocol exchange are incredibly similar after they threw away all the
revlog stuff.  Or is it just that they're fine with the speed loss and
the Android project would not be?

Scott
