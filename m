From: David Miller <davem@davemloft.net>
Subject: Re: rogue tree objects, how to diagnose?
Date: Sat, 28 Feb 2009 21:57:52 -0800 (PST)
Message-ID: <20090228.215752.122159841.davem@davemloft.net>
References: <20090301032035.GB30384@coredump.intra.peff.net>
	<20090228.194454.05711858.davem@davemloft.net>
	<20090301034632.GA318@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Mar 01 07:00:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdejI-0002Pf-GM
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 07:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbZCAF6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 00:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbZCAF6M
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 00:58:12 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39635
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751129AbZCAF6L (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 00:58:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id BBA9735C009;
	Sat, 28 Feb 2009 21:57:52 -0800 (PST)
In-Reply-To: <20090301034632.GA318@coredump.intra.peff.net>
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111818>

From: Jeff King <peff@peff.net>
Date: Sat, 28 Feb 2009 22:46:33 -0500

> On Sat, Feb 28, 2009 at 07:44:54PM -0800, David Miller wrote:
> 
> > > "bad object" is about an object that did not parse correctly, as opposed
> > > to one that is missing. So it's possible that your repository is
> > > corrupted.
> > 
> > I see.
> > 
> > I GC and repack my local repos a lot, maybe it happened during
> > one of those.
> > 
> > Thanks a lot Jeff, I'll try to fix the corruption using the
> > suggestions you gave me.
> 
> If it is real corruption, you might want to save a copy of the
> repository. I think Linus and Nicolas like to pick apart corruption to
> figure out if it is a git bug or a disk failure.

Indeed I have some serious corruption in my pack file.

I've put this .git dir up at:

	http://vger.kernel.org/~davem/netnext26_git.tar.gz

if anyone wants to have a look.

davem@sunset:~/src/GIT/net-next-2.6$ git fsck --full
error: d7d82ec12e618a3152a82f7fbd459ad285403740: invalid sha1 pointer in cache-tree
error: 95381186c4ef9d69f56bb6a9f7334ebe81dd023c: invalid sha1 pointer in cache-tree
error: 6bea4ad565fff638d396298cb6ee7ad6a31ca252: invalid sha1 pointer in cache-tree
error: 3c8b516f2a9634410f6c3a0ee639627d7c4a83d2: invalid sha1 pointer in cache-tree
error: 11f0695e84bc3f83a6eea0d6fb0af2789de351ef: invalid sha1 pointer in cache-tree
error: 7b3c81544c3117201c160af43fa983d68c614e3d: invalid sha1 pointer in cache-tree
error: c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844: invalid sha1 pointer in cache-tree
broken link from    tree 0b44b1f3ec61d2ce0867be1f852b97283b94eedc
              to    tree c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
broken link from    tree 58695269e5993af5f2a609e76802b533cfdb9db3
              to    tree 3c8b516f2a9634410f6c3a0ee639627d7c4a83d2
broken link from    tree 3991e80e4c4451b1b47f0faeac21d0c1061a9326
              to    tree 11f0695e84bc3f83a6eea0d6fb0af2789de351ef
broken link from    tree 3991e80e4c4451b1b47f0faeac21d0c1061a9326
              to    tree 7b3c81544c3117201c160af43fa983d68c614e3d
broken link from    tree d1dacf352e9a5bfa7cd0c7dd0c9c75162e08d9d1
              to    tree d7d82ec12e618a3152a82f7fbd459ad285403740
broken link from    tree d1dacf352e9a5bfa7cd0c7dd0c9c75162e08d9d1
              to    tree 6bea4ad565fff638d396298cb6ee7ad6a31ca252
broken link from    tree d1dacf352e9a5bfa7cd0c7dd0c9c75162e08d9d1
              to    tree 95381186c4ef9d69f56bb6a9f7334ebe81dd023c
broken link from    tree 0e43808595dd55e895f964dd49a1b85da497597f
              to    blob be9f38f8f0bfae3173d452e48df8b4db2f747bb6
broken link from    tree f76062dd2e3cb4d295f7c9b7080550e70be8ccf4
              to    tree 84ad0b83cea94ad0968adf38160a417677dea619
broken link from    tree 380715fdabcb6d11f82855cd3aad91c26db6ab14
              to    blob 0d7ba117ef608debcafeb4185809a882487d6134
broken link from    tree f8f962e573fdd1587129a0d89299000f3e345c33
              to    blob b2563d384cf2998a8b763cf9767146716b718b86
broken link from    tree f8f962e573fdd1587129a0d89299000f3e345c33
              to    blob c23a58624a33fc00ea301e57aae28424c41aca6e
broken link from    tree f8f962e573fdd1587129a0d89299000f3e345c33
              to    blob 98fe79515bab97bf2f8ff8d60d5ba35c94a4fa35
broken link from    tree f8f962e573fdd1587129a0d89299000f3e345c33
              to    blob 4671436ecf0ed236d3263e9f0ac70096fbe4e6ec
broken link from    tree 44aaf82d6df7245787b59a48e741a6cfa7fcb3db
              to    blob 0b2b7925da222b6668a873d34502ec33e18613a7
broken link from    tree 44aaf82d6df7245787b59a48e741a6cfa7fcb3db
              to    blob 77dc9da4c0b9dc7f3b9a55fc8c95bca47554cda6
broken link from    tree ab279f68b6889e40d361927580d0533d8acd0152
              to    tree 7d65abd29976f39dbcfba0867c9ca309decec7ca
broken link from    tree ac5393f38d94651a759d737c2377130716a26867
              to    blob 0821bac62b83449bfad09dad77eab8b7e244499a
broken link from    tree c748508a2da3916633c639c04cf1a97e5bc5f1a6
              to    blob 3da9f394b4c6d6616868d53ad3e8f6d528c7905a
broken link from    tree c748508a2da3916633c639c04cf1a97e5bc5f1a6
              to    blob ed5b37d43334577ad76c728805a7cf722cf0aacf
broken link from    tree 1870862f8d1267b181a0424a79b5cda4045888ab
              to    tree 655c2f4e128fc3ae2b259a6e8f4dad956d5da0b4
broken link from    tree 676f5498f67e6f7f7a650ff95bbbc8396e259793
              to    blob a80d4a30a4643ae18f5902f05b8e4fc89c6fb99d
broken link from    tree ff106c8c0934a23c305346645cecbdc83512aa33
              to    blob ea1ad8ce883640cf73e9ddfcbcff00e491c6f670
broken link from    tree 2f7b88af38fa44b41d71722473dded44c7415bd7
              to    blob d58919c7032ea17cf6aa5ac83dd2154975afdd32
broken link from    tree 2f7b88af38fa44b41d71722473dded44c7415bd7
              to    blob 1c4a980253fe1730b0bbd18ebc818badc74f9825
broken link from    tree cc0655d58e4f7f0cb2611482b2ee4e4ab6b80045
              to    blob 875509d7d86bd773b53e522c87c07309a1cd768e
broken link from    tree bd51cca35efe8b3b8066a30e07c54f2391e27086
              to    tree d0ad10933fe0681952e5bd33dbcbb7f0927eeff6
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    blob bb46be275339df3bd7127c7051e932f3a6252228
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    tree 6a61be7e171eb9d2a89ac5bca5a6746222c976a9
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    blob 4a5a089fa301943c1977264abb9f9cface6c0516
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    tree a40d7116ba4a890474e9b2ff7484dc15d95ee6f2
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    blob cc0f886b0c29bc4882a97023cdce7e444e287fbf
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    blob 2a96a10fd0cffc1b91e091e6a888b2a200e380eb
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    blob 4942059109f3ffbbcb2c49e0f66688cc6eb65487
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    blob 1138782e56116ab6a03d7a140516c946304b4176
broken link from    tree 8f0ed806072b760556a9945f5e2b2ed7ffaaa046
              to    tree d811e0db21c8cca9e64c1a48175e93dfc4d277ee
broken link from    tree 897d3a8d995b0c9fcd7445caeb99cbce8ffb6167
              to    blob 57159e4bbfe1e53853e315d5829b3cd247b5af04
broken link from    tree b781658af16f9918a06ebf24f211c1c4e549acd8
              to    blob 43da8bd7297326aaf01af73b7cca9ebb8fa8ee1c
broken link from    tree b781658af16f9918a06ebf24f211c1c4e549acd8
              to    blob af3fd4fead8a680c297f24986cfc3015e879f55d
broken link from    tree b781658af16f9918a06ebf24f211c1c4e549acd8
              to    blob 70e57cebc9556f9ea397df91002f3be414153d2e
broken link from    tree b781658af16f9918a06ebf24f211c1c4e549acd8
              to    blob 7b8a5eae201d2dcc26d1b0598cb0cbf65472cf9b
broken link from    tree b781658af16f9918a06ebf24f211c1c4e549acd8
              to    blob 6e92c64ebd0f64f3c513541be1741a5d8ba84032
broken link from    tree f65b5a98d04aebe608ca9030aee1275097e5dab2
              to    blob fb1ac0e63c0b8cb53a3b8fcc0ec28324fc3f254e
broken link from    tree b278562c46671423052ad7ac1521c674185f6262
              to    blob ac55ebd2f14637d68894993489b8aa4d107b4ade
broken link from    tree 19b2a2199147e1c3e4754aba78b64e287f4f46ae
              to    blob da017cbb5f641c0d8bf3c35fe346df660cdb7554
broken link from    tree 19b2a2199147e1c3e4754aba78b64e287f4f46ae
              to    blob 1613929ff30182cacd766e1464fdc4d84b3fc7e1
broken link from    tree e98b321c04f2b2d27816d3152909a5c009f9baa7
              to    blob 4dad04e91f6de9906b0f9ccac417130588e5da7c
broken link from    tree e98b321c04f2b2d27816d3152909a5c009f9baa7
              to    blob 3e11c1d6d792090e4288211cf8cd4eb0fe404ae6
broken link from    tree e98b321c04f2b2d27816d3152909a5c009f9baa7
              to    blob 79f4c228b0307c41e0158b738b09479e23b83a65
broken link from    tree e98b321c04f2b2d27816d3152909a5c009f9baa7
              to    blob f42c67e93bf4a49345e88a2267ebb6f28373ef5d
broken link from    tree d117ac17eca7cfead9af9d3a0fed3c058e65c087
              to    blob bca08eff4a778f42357758aa02fe408298b3ec8a
broken link from    tree 2c99d8acbef947fdf8f532cde82c9d903f3d176a
              to    tree 497c7636ac99d40def91cc3c5f71b4418a079148
broken link from    tree 2cd3bba61c24ead2202d60016a761bbc201df298
              to    tree 3912e6654c49d5642ae5c09ca86ad25e62fe01d3
broken link from    tree 13ddb64e31756585bd923ba06d05fd77103adb39
              to    blob 350afa773f8fc0706c2c4d8684dc084ad5d80bc5
broken link from    tree 45bc4e0567f03f822c7aafc446c72d912a63c26f
              to    tree dd7feca92f87289b8857e3979b917bbfa65d082b
broken link from    tree 4f608d6c0510dbe5e31e54b45cdeb24600cff76a
              to    blob e817802b2483b6a6285c16f96cd752c3e0e2f7d3
broken link from    tree 7396592691485134f658a70ab9a938a9b36c8248
              to    blob 30ae6d9a12af7016f81c8d6d656417986cb0b96a
broken link from    tree f7d096fedd98dae3f5b66add915176c4132453fc
              to    tree 5202923b048249b2cc14103683a99977ce51bdad
broken link from    tree 362a5be8d90cf13efc34e4ea8ccd6c16b81beed9
              to    blob dcff5ade6d0847b9f9970ac424edefa2ea709927
broken link from    tree 8164f6bcfd65fb40f07743d0b3f96ffc7a36500f
              to    blob 77aca5d67b57a6066872a73137c70a9417e40a2f
broken link from    tree e7a8311224bc844bd910b00b6da526c5148676c7
              to    tree e50549f8ef9e7dba7c6bd62c7da7125255d2e9c7
broken link from    tree 85ad5e46fa37bfc0875ffd34d990f2017e540069
              to    tree 047a1f3aa7db72eb8077e14fbddcc827ccc91456
broken link from    tree d43273bb6d5c26146ad0d8546a874e93a8108af8
              to    tree 57adff8129b0dd6b05e10b13a776b6a18e51892e
broken link from    tree 57959d9bcd24d25a5c061b1b736aae838997bbd3
              to    blob dbc179887f8b9840b37154e73baaf8751b3e6bf2
broken link from    tree 7d85c1d0c330a7cf64409a55fbdf42792eddbda9
              to    blob d83cd7884e05b5a144d942f34b9d72ab5f1d6a14
broken link from    tree a7d3a0328ee2d7bdac85c8d524e267622a80a320
              to    blob 4bf0f19ecfa36f42b2488e6681a77e7dc4d3b202
broken link from    tree a7d3a0328ee2d7bdac85c8d524e267622a80a320
              to    blob 6fc0e698bcb7e2053a7e7f11bcffcf72d7bc2953
broken link from    tree a7d3a0328ee2d7bdac85c8d524e267622a80a320
              to    blob 49f9d2491d4774bf6fd044e5b539e575e198c5d9
broken link from    tree a7d3a0328ee2d7bdac85c8d524e267622a80a320
              to    blob e2b0a19203ac5e9527a0b52d70816aaba44057f4
broken link from    tree 24861658ac3688249c1ebee3bd6ffd50520abaf7
              to    blob be280871e9ac0d0b6d5cfdaf323b13b42f86697f
broken link from    tree 877d90a0b653a86a35e9ac12accaf653a833bc4d
              to    blob 1215a49c38f1667b367b810b53e16cffeae2a1f3
broken link from    tree 871a514e1d0e7b942f051f87560c87e1538dbec2
              to    blob b0817ea56bb95c964f12cd167084eb66df39e140
broken link from    tree b924d24f811663ff87c08de46306918aa049da9a
              to    blob b662b67125bc8f4cf2c745cede695f10c4189663
broken link from    tree 367abbfec10de1d42564a90c3df7988e9c5d5031
              to    blob c6e4ec3ade694b39b5dc1abe62af9764b9a12605
broken link from    tree 1702e2fedc00361f73312eef5a2c66c8415e2897
              to    tree 014aa3a9a992c017a059ed61b4c6599a40a0cad1
broken link from    tree ee2011a6c8a8e9542a216eba25f95d7d3c245cfc
              to    tree 255ca0d434cb6f684bee7cc7a38e17a22439dafd
broken link from    tree cf3f8a6d6e75e5fff21c35ba54f626947c7da452
              to    tree bb2a6f716ee621d4097305dd0edb68330f3d7444
broken link from    tree bce6eea0a14a1b67e5c4e836d95f9e88fc13b6fc
              to    tree 132441094141c548605b92571ed9903d0d298c2e
broken link from    tree 723c02dab42deaabd59cd3bd5cae9a2dae206c0d
              to    tree 5ad5ae0bbdb333f85a82e0041287feff572d4f2e
broken link from    tree 57fbcc6e3a38f83558d9e47dbfc890aaa3a51fa3
              to    tree e4944fba6fb553b8d0d7d9430083d9bfd0a522db
broken link from    tree 62224446c767e0de6adb835e6dd0974cfbfbfbbe
              to    tree ed12b235be8f8d2ac29d6d6a7b2d9e2500365103
broken link from    tree 557d6e037f102b26b5ddb1f6067b4f83891f314b
              to    tree db2ed53f6a1a6e343f943bd3513f9e233d0302e5
broken link from    tree a13ed09130f825541b02c41410c0b366c7d656b0
              to    blob ef0d6b7df44ce8e02cdef5be866c3b4eb80aacb4
broken link from    tree 05125698d42905d19b6220629187158e8403a52e
              to    tree bf96095d753092e77f7ecf56e3f9f048e533ca60
broken link from    tree 0c6c86358f0fee4b1d2ee7aa23366e16590d4864
              to    tree 1227a659146ed3692c87abdeb05a3659ac774550
broken link from    tree b9254a952f83e0729fe6e252a934bdc1c70cd447
              to    tree 569c5e4613d38dbeecbc1bbe6caaa6cc37b6d0f1
broken link from    tree 09b92c54c77be558fedbdbbcb134a9e2ae981d21
              to    tree 611bc468d6c449080f5994ce1a69be7666b54720
broken link from    tree 0c2fca1e261997a00338cf548a50c0ffffc65586
              to    tree a1b71fdb78585ac5e815829d052a0370d52ab3d2
broken link from    tree caa555c244be63dd8dcd0862ab78b6ee2ca0b38e
              to    tree b80cbbfb50668f445e3c1b7cebc2ef556d9a23c8
broken link from    tree 73752b2dc3ac951b5a253bbb42618c0e95faea06
              to    tree 8bc4a26447eaf8ffb08c66a568490caa6bb29105
missing blob 6fc0e698bcb7e2053a7e7f11bcffcf72d7bc2953
missing blob 6501396265819eec021f89eade0f4f7e1551bdfe
missing blob dbc179887f8b9840b37154e73baaf8751b3e6bf2
missing blob da017cbb5f641c0d8bf3c35fe346df660cdb7554
missing blob b0817ea56bb95c964f12cd167084eb66df39e140
missing blob 5341da604e8465df4aafedf5ebba6404db627ee6
missing blob 4942059109f3ffbbcb2c49e0f66688cc6eb65487
missing tree 5202923b048249b2cc14103683a99977ce51bdad
missing blob da42fd06b61fc6c6c93a47b7336d15bca2438373
dangling blob 69c3a09b401fc54aff81d37aca4799a434064715
missing tree 8bc4a26447eaf8ffb08c66a568490caa6bb29105
missing tree e50549f8ef9e7dba7c6bd62c7da7125255d2e9c7
missing blob bb46be275339df3bd7127c7051e932f3a6252228
dangling blob f286c4fef802462dccedf681263b7a03955f245b
dangling commit 2a07954b83a3d4dc93031d3ce030fb9380a8e15a
missing blob f5484ad1279bd2110a253870b482b7de5fc8b537
missing blob 5608a1e5a3b3416fa44e44e504c9a2817d1c3c2c
missing blob 1108f3e099e3bcb7a80b89c9ee2f43fa5dcefa88
missing blob db08fc24047a5b569a3f0e411b1cafea435cd5e2
missing blob d58919c7032ea17cf6aa5ac83dd2154975afdd32
missing blob 9d896116cf761b6aea8a6b294a2da95fa07238f5
missing blob 044a48175c42e4d4076d950cc23b0a2ffc162765
missing blob 7b8a5eae201d2dcc26d1b0598cb0cbf65472cf9b
missing blob 1c4a980253fe1730b0bbd18ebc818badc74f9825
missing tree 014aa3a9a992c017a059ed61b4c6599a40a0cad1
missing blob 350afa773f8fc0706c2c4d8684dc084ad5d80bc5
missing tree 3c8b516f2a9634410f6c3a0ee639627d7c4a83d2
missing blob c0cba9a037e842d92ac7116907b21c950b001b2d
missing blob cd4bcb6989ce0e888d7e62f1e771c18e9b2f404e
missing tree b80cbbfb50668f445e3c1b7cebc2ef556d9a23c8
missing blob a80d4a30a4643ae18f5902f05b8e4fc89c6fb99d
missing blob ef0d6b7df44ce8e02cdef5be866c3b4eb80aacb4
missing tree a40d7116ba4a890474e9b2ff7484dc15d95ee6f2
missing blob b60e27dfcfa7c24a3c576ca1f5713e30befb4d60
dangling commit 778ef1e6cbb049c9bcbf405936ee6f2b6e451892
missing blob 7dcf2569613b612eb3a19f9777cbc71edaed902a
missing blob cc0f886b0c29bc4882a97023cdce7e444e287fbf
missing blob 334fcd4a4ea469c26ecdc958b40ffa5b74d35f1e
missing blob 9f102a6535c4976b6a7451a75bcdb19386d5d718
missing blob b61073c42bf8641b1623243e5fa30d19299b79aa
missing blob 35517b06ec3ff39901f8eeba255146e84ea8e7b0
missing blob 3e11c1d6d792090e4288211cf8cd4eb0fe404ae6
dangling blob c351d34a71931e6e20d021cedab4a1f9294b1cc4
missing tree d811e0db21c8cca9e64c1a48175e93dfc4d277ee
missing blob 80124fac65fa83682a7b256db5dd11039fb7d445
missing tree ed12b235be8f8d2ac29d6d6a7b2d9e2500365103
missing blob 6e92c64ebd0f64f3c513541be1741a5d8ba84032
missing tree 3912e6654c49d5642ae5c09ca86ad25e62fe01d3
missing blob 1c5344aa57cc32473a0b019d7ab1205e3df2b9e0
missing blob 351372463fedd23f5c61bd9b016cb8337c800f07
missing blob 1613929ff30182cacd766e1464fdc4d84b3fc7e1
missing blob 9693b0fd323dbb82c252ba53720ab971445af126
missing tree e4944fba6fb553b8d0d7d9430083d9bfd0a522db
missing blob 00945f7c1e9b07f7c3c0db54bf0d6db698825ece
missing blob 9f946d4210885f3650ece6ece8629fc8a1c0724e
missing blob 9d14d196cc1d74aa9ea06baec24ba5772cc2c24b
missing blob 875509d7d86bd773b53e522c87c07309a1cd768e
missing blob 745530651c454c3fd25ab85313e90e40b69624a9
missing blob 57159e4bbfe1e53853e315d5829b3cd247b5af04
missing blob 1215a49c38f1667b367b810b53e16cffeae2a1f3
missing tree 5ad5ae0bbdb333f85a82e0041287feff572d4f2e
missing blob ac55ebd2f14637d68894993489b8aa4d107b4ade
missing tree bf96095d753092e77f7ecf56e3f9f048e533ca60
missing blob b2563d384cf2998a8b763cf9767146716b718b86
dangling tree 5d168141803d4eddb7572da4b5959317095150f3
missing blob 2a96a10fd0cffc1b91e091e6a888b2a200e380eb
dangling blob 9fd6a65e8315c5c08120dfd57d920e159971a25a
missing blob e817802b2483b6a6285c16f96cd752c3e0e2f7d3
missing blob 0057a8f58cb1261c71b48db67f1562d74282ee59
missing blob b397e8785d6d3e5c3f7eb9ba8e3683214dddf9e1
missing tree d7d82ec12e618a3152a82f7fbd459ad285403740
missing blob c758884728a53ee545879d61cc5b128de2bbe219
missing blob 3c58d6a3fbc98a5420975b1f4182915840235c0a
missing blob 4a5a089fa301943c1977264abb9f9cface6c0516
missing blob 83da596e2052a84df3920cb2d681579e0caa9205
missing blob 43da8bd7297326aaf01af73b7cca9ebb8fa8ee1c
missing blob fb1ac0e63c0b8cb53a3b8fcc0ec28324fc3f254e
missing blob ea1ad8ce883640cf73e9ddfcbcff00e491c6f670
missing blob b9db1b5a58a3db04af268a0c5148ac147aa40c89
missing blob ed5b37d43334577ad76c728805a7cf722cf0aacf
missing blob b11bb72dc7abae085326c605351cd92f52c6f70d
missing tree 611bc468d6c449080f5994ce1a69be7666b54720
missing blob 881bf818bb48aac8a71672b4cd2677b2588613a4
missing blob b1dc29ed15835675b1231505fc25696a62f29f73
missing tree 655c2f4e128fc3ae2b259a6e8f4dad956d5da0b4
missing tree 569c5e4613d38dbeecbc1bbe6caaa6cc37b6d0f1
missing blob cb9c95d3ed0ab45854da0e1b1e8e0240c6c044d6
missing blob 77dc9da4c0b9dc7f3b9a55fc8c95bca47554cda6
missing tree 255ca0d434cb6f684bee7cc7a38e17a22439dafd
missing blob 861d2eeaa43c1bd34deaeefc956d5d3f62a1788e
missing blob 61de56e45eedb509bc33bca2ed120b4868ab5c7f
missing blob be9f38f8f0bfae3173d452e48df8b4db2f747bb6
missing blob 53df9de23423bdcb9a96a7d4ea0992e6694bde43
dangling blob d3dfef43b4a6f097b580a4b014f7438625011255
missing blob da6082739839968ed3c64cc402a3bb438b28b8eb
missing blob bca08eff4a778f42357758aa02fe408298b3ec8a
missing blob 5fe17d5eaa5440a4ea81a3f439ba0bbd40603f13
missing blob 0821bac62b83449bfad09dad77eab8b7e244499a
missing tree 6a61be7e171eb9d2a89ac5bca5a6746222c976a9
missing blob e321c678b11c098f7436a9eb950912c50d6f47f1
missing blob b662b67125bc8f4cf2c745cede695f10c4189663
missing blob 30631bae4c9481e6676911e20659c285c74c2ec1
missing tree 132441094141c548605b92571ed9903d0d298c2e
missing blob 1ba4509435f8fbfc2f021eea0575956ae1068906
missing blob c6e4ec3ade694b39b5dc1abe62af9764b9a12605
missing blob 70e57cebc9556f9ea397df91002f3be414153d2e
missing tree 7d65abd29976f39dbcfba0867c9ca309decec7ca
missing blob 4a65fc2dd9282ffef9dc72a92a559c90b85dd7e3
missing blob 49e68f5ca5f2c95630635ac0fdf7a74512ce90aa
dangling blob b4271da84618870c1846738cda002780e177aa4f
missing blob 72277d70c980be38035f11bc7aae0a1be46b8398
missing blob cba7849de98e26988d93bd4ee6058be4ce7f0558
missing tree 1227a659146ed3692c87abdeb05a3659ac774550
missing blob be280871e9ac0d0b6d5cfdaf323b13b42f86697f
missing blob 8b2823c8dccfafaf97b3b8c9f698cb25386d34c4
missing blob cca94b9c08ae5360428554fcff302620009488b4
missing blob 06695b74d40585e5ef8428372c6327682745807b
missing blob 15696b1fd30fbe85c248ad95fba4a4e7db4f4454
missing blob 0a6992d8611b6178cbc1a29b94914fd57148d3a4
missing blob 3da9f394b4c6d6616868d53ad3e8f6d528c7905a
missing tree 6bea4ad565fff638d396298cb6ee7ad6a31ca252
missing tree bb2a6f716ee621d4097305dd0edb68330f3d7444
missing blob 8f2a888d0a0ac7226ec61f06ac7da2893c1f876e
dangling commit 5baa8d3816f8032b2b96343ae910971168e2294b
dangling commit 0ceab41809180a4214383ab196b2e13a98801244
missing blob 7f6b4a4052eed1ef5e46a3cfcdea456fe636cc46
missing blob 0b2b7925da222b6668a873d34502ec33e18613a7
missing blob f42c67e93bf4a49345e88a2267ebb6f28373ef5d
missing blob 77aca5d67b57a6066872a73137c70a9417e40a2f
missing blob 60ece54bdd940452f301215743b4658c7bbe2e59
missing blob 8face5db8f32a132be74c053ccafe6fec25d4ae1
missing blob 4dad04e91f6de9906b0f9ccac417130588e5da7c
missing tree 84ad0b83cea94ad0968adf38160a417677dea619
missing tree d0ad10933fe0681952e5bd33dbcbb7f0927eeff6
missing blob 952d37ffee51f8de796a20b650b946678ca5e333
missing tree 57adff8129b0dd6b05e10b13a776b6a18e51892e
missing tree c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
missing blob 30ae6d9a12af7016f81c8d6d656417986cb0b96a
missing blob 6a6e701f1631622c950a0dc25174184036ce18b5
missing tree db2ed53f6a1a6e343f943bd3513f9e233d0302e5
missing blob e2ef16b29700ed0c0d81e258338c978f5f65f1b5
missing tree 11f0695e84bc3f83a6eea0d6fb0af2789de351ef
missing blob e2b0a19203ac5e9527a0b52d70816aaba44057f4
missing blob 4bf0f19ecfa36f42b2488e6681a77e7dc4d3b202
missing blob 4671436ecf0ed236d3263e9f0ac70096fbe4e6ec
missing blob 45b1822c962dabf212b644092b761ac674264079
missing blob 23b26902745310b5d93fca475467e25a6487fb23
missing blob 60b30ee38dcbea0dd7d1c116eff56834ec32ec8d
missing blob 8f734d74b513f66b33e3c89b7c8779125e832246
missing blob 79f4c228b0307c41e0158b738b09479e23b83a65
missing blob dbf4de39754d1f4009edfdb02f4bfa1e80e56baa
missing blob e035d8c57e119b5d0a875d503b25821c1b64b548
missing blob 8eb6c89a980ec1cb674eef7fe83e42142ea4d5cf
missing blob cc7708775da0c91e4e86a713a13ed17b781a1cc6
missing tree a1b71fdb78585ac5e815829d052a0370d52ab3d2
missing tree 95381186c4ef9d69f56bb6a9f7334ebe81dd023c
missing blob 1138782e56116ab6a03d7a140516c946304b4176
missing blob bb78c11559cd2cd9cb0876cbe2630816b539aea3
missing blob 06f8fa2f8f2fb90b0317bf02cdacb3476a2823c7
missing blob 49f9d2491d4774bf6fd044e5b539e575e198c5d9
missing tree 047a1f3aa7db72eb8077e14fbddcc827ccc91456
missing blob c23a58624a33fc00ea301e57aae28424c41aca6e
missing blob 887acb0dc8075f183925c19225d5d4cf725695dd
missing blob fbbaf826deff829531a6dddaac7d652146df030b
missing blob 497b003d72392a1ba87968ba3ea8fc47b077f610
missing blob 0d7ba117ef608debcafeb4185809a882487d6134
missing blob 167bf23066eab6e5e376d4356acde830f2e06aaf
missing blob 467c531b8a7ef84cc2610eb78ebb137799135ec2
missing tree 497c7636ac99d40def91cc3c5f71b4418a079148
missing tree 7b3c81544c3117201c160af43fa983d68c614e3d
missing blob d83cd7884e05b5a144d942f34b9d72ab5f1d6a14
missing blob 567d4f5062d6517bb397895093ebc560910ff023
dangling blob 1b7d7547e766c5516801bd8799541b19821d54fd
missing blob 98fe79515bab97bf2f8ff8d60d5ba35c94a4fa35
missing blob d3bf2f017cc27f0507b393a07761b198a15cd123
missing blob dcff5ade6d0847b9f9970ac424edefa2ea709927
missing blob af3fd4fead8a680c297f24986cfc3015e879f55d
missing tree dd7feca92f87289b8857e3979b917bbfa65d082b
